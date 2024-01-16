Return-Path: <linux-can+bounces-135-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3A82EA60
	for <lists+linux-can@lfdr.de>; Tue, 16 Jan 2024 08:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EBE1F23FF1
	for <lists+linux-can@lfdr.de>; Tue, 16 Jan 2024 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C4111A8;
	Tue, 16 Jan 2024 07:55:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435E1119A
	for <linux-can@vger.kernel.org>; Tue, 16 Jan 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36037f2de0aso83617935ab.0
        for <linux-can@vger.kernel.org>; Mon, 15 Jan 2024 23:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705391719; x=1705996519;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMsQsTLKvb1FkzCsH1qgj8RoFtThY6wbiVssNEiJIdI=;
        b=IuNgiYPEi8hqfH4TM/UozFdiTwNu7jhVWn7P/LudtNtLCRXfb+mlUDmBWyvKZq98n+
         sR5TW3vie+Fp6kzv4KDbKnRvRpxZTBmcdV5o7mtBoS634CZdKHDZt+/GUNmOhXFIHwH9
         WKUtdFK9q/f2s3eGsQ+Lb12mkHC74+EcBglWQZckRMJ3klEDVnJOSVOtXOIRPhC2LTV6
         5sDqIah2eqHszpBmCuyYOhWbNLDYSeIwIPhvLIeVrom163X9mzbMgjnZGDjxmyXHTlTZ
         F9PZwOCn0ycKEsbOSUt8tkgUqQefGjDXSlI4f/53FNfSmYES5/Sa7/1of2RgWTqzNTLY
         KIzg==
X-Gm-Message-State: AOJu0YwZw6xnxWsanUS9APKebcYEVzKoQ6YbTwGBqjOAKtD17EGVwxKW
	WkE1KTyv9DdZhXEIpqts7APDXcQdI6Al/dvPoZKWv18KkTY5jXY=
X-Google-Smtp-Source: AGHT+IE1/dlZSSnwqrw3wDBdBH6sno/GbfNX3CSQeTqoOyA14hD0utDfgkPDDN41N7bzUCs/G1ayGkH5PEhPbfuCH4QVc+9PEeGW
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:35d:61b6:c776 with SMTP id
 h7-20020a056e021d8700b0035d61b6c776mr1014004ila.0.1705391718973; Mon, 15 Jan
 2024 23:55:18 -0800 (PST)
Date: Mon, 15 Jan 2024 23:55:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cc698060f0b7364@google.com>
Subject: [syzbot] Monthly can report (Jan 2024)
From: syzbot <syzbot+list73e9230888c286ba3102@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 47 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 159     No    KMSAN: uninit-value in bpf_prog_run_generic_xdp
                  https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<2> 9       Yes   possible deadlock in j1939_sk_errqueue (2)
                  https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
<3> 1       Yes   memory leak in can_create (2)
                  https://syzkaller.appspot.com/bug?extid=521ac15269e89d8546e8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

