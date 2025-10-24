const functions = require("firebase-functions");
const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "moamengebril5@gmail.com", 
    pass: "erlrdecpyzrjnlbm",    
  },
});


exports.sendVerificationEmail = functions.https.onCall(async (data, context) => {
  const { uid, email, displayName } = data;

  if (!email) {
    throw new functions.https.HttpsError("invalid-argument", "Missing email address.");
  }

  const mailOptions = {
    from: "AlgorithMat <moamengebril5@gmail.com>", 
    to: email,
    subject: "Verify your AlgorithMat account",
    text: `Hi ${displayName || "there"},\n\nWelcome to AlgorithMat!\n\nClick the link below to verify your email:\nhttps://visualalgo.web.app/email-verified\n\nBest regards,\nThe AlgorithMat Team`,
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log(`Verification email sent to ${email}`);
    return { success: true };
  } catch (error) {
    console.error("Email send failed:", error);
    throw new functions.https.HttpsError("internal", "Failed to send email.");
  }
});
