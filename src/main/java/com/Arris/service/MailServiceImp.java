package com.Arris.service;

import com.Arris.models.MailRequest;

public interface MailServiceImp {
    public boolean sendEmail(MailRequest emailBody);
}