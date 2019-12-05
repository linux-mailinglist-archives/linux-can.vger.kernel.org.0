Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E141114867
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2019 21:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfLEU4H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Dec 2019 15:56:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33049 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbfLEU4G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Dec 2019 15:56:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so5230782ljr.0
        for <linux-can@vger.kernel.org>; Thu, 05 Dec 2019 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4TwRmWHgFj9WbyxNrZ+etk7I6uTDgVHvLjHkyyBiRsE=;
        b=RVYfx20k52bMvGexm9qzXw8/Hv9rW7ftVCKAUkJbn0eEp2Kbbi1cpSq3xuzLb0ECDV
         b+lOt0aaba7g6fxBXqqoC7ieUTKzckQUODDDWEum1WWm0xj7ypxSAwhKUs0D+ZyDLxcU
         Bgt+h/H+U0l8Thgpb7RewUNRFrjqyJps+MCoTqHV8b6tCQdjxodPg7mxzIA/zqhI4oZy
         LZpD/0jyMlwD/Epeqo+4WaksE5CztF9itcZJUhQbX/qHLMfJSYpJQr9QpLBCxSRGEM+j
         CMiW4dtbhYTe1n2PxwMHf93szcENH2Qc7O+JbaXB1P7oJA4aC9nxxZrvKONtaCvO5QXb
         KI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4TwRmWHgFj9WbyxNrZ+etk7I6uTDgVHvLjHkyyBiRsE=;
        b=cORnAGHFOOYG57PlXAFoxb1Qq7Gw37mpo5YmFyWbdbaEMffgp9YCSOQEciLKDMmMy5
         sBVXwWGxyK0SMAZ3GyaedynItvL7WvV3xAD3yVWtzcqF3zsDbCdOZG+qGr7JVCMsoVJ+
         /lqngKAHlAn/PnHCBDXV1QsrotNs33rNWRrEIDnrDcvyjFCGInEVk39DGdZFtlWc94zz
         e9J36fBnqOELR09hx1HIe+0WiupFjBWvGPobTNzPuLo52LVp0A+Ez6GRd+xv+Mj2DDim
         gmuCV7lSIuPl0kz7aWFHMB43YahbcuYOk3IBAZbQ3W+88pTx8qTj/UCRydRD4JGcK6yn
         Hyww==
X-Gm-Message-State: APjAAAVgnkzXjnKfykRENX7kIZ4BxapNTYl2PA2chSRG3gUbnbnT6uyG
        d9BIl0f1hl/A4jW/ecFeWaFrl+vtfOkuFke45A6zGpY6
X-Google-Smtp-Source: APXvYqwOBDXmFIQxtsvkT6/HkSUKlhDzfSlSwuptdyyEK0mQP9oq2rkjlunJrVG+hhAAN6xwMkAwxmnlCegfyZXW8Tg=
X-Received: by 2002:a2e:9008:: with SMTP id h8mr6869765ljg.217.1575579364594;
 Thu, 05 Dec 2019 12:56:04 -0800 (PST)
MIME-Version: 1.0
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Thu, 5 Dec 2019 14:55:53 -0600
Message-ID: <CAHChkrstQdjVcWtvX4oeUOQfZS3-G_RPWb8Y82Zvaku40dM_qA@mail.gmail.com>
Subject: can-utils jacd questions
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

I am hoping to re-use the can-utils' jacd as default Address Claiming
daemon but runs into some issues:

(1) " err(0, <string>, ...) " is called in several places, even though
looking at the code logic, there is no error and the program should be
able to continue. The program exits because err()  never returns.
For example:
    if ((s.current_sa < J1939_IDLE_ADDR) && !(addr[s.current_sa].flags
& F_USE)) {
         if (s.verbose)
            err(0, "forget saved address 0x%02x", s.current_sa);  <<
         s.current_sa = J1939_IDLE_ADDR;
     }

A few more examples:
     if (s.verbose)
         err(0, "ready for %s:%016llx", s.intf, (long long)s.name);  <<
    .  .  .  .

     if (s.state == STATE_REQ_SENT) {
                if (s.verbose)
                     err(0, "jacd: request sent, pending for 1250 ms");  <<
                schedule_itimer(1250);
                s.state = STATE_REQ_PENDING;
      }

(2) The socket is configured to also set the SO_BINDTODEVICE option.
In our system, this requires the program to have root permissions to
run but we'd rather not do this for security reasons. Is this option
required? What are the side-effects if this option is not set? Can it
be made optional such that the program does not exit if the
setsockoption(SO_BINDTODEVICE) call fails (seems to work without it)?

(3) The claimed address is only saved to a file when the program
terminates.  What is the reason for this? Can it not be saved after
one is claimed already so that another process can  read it real-time
if needed? Also, in cases of a program crash or a power outage, the
claimed address is still saved.


Thanks in advance,
Elenita
