Return-Path: <linux-can+bounces-1860-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98E9BAE8B
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 09:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F2B284FF0
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5968A1AB52D;
	Mon,  4 Nov 2024 08:50:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BF18A6C3
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710226; cv=none; b=Te2Yp0t0ilFri1ULs2zJgsV8Ehrll4UgjIbYNUji/3+SkUf8ohSYTsrnKmde24wJhTI2Kox8zjSF3YW4pTdwcL10AfCf7363AU3Ct4I6CvB1ZnJeAsTT4GtFf2lK6dyjz/b/EFV+eE5dTZI8yuwXlNZLkdtwpeEzdlP69jJYeTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710226; c=relaxed/simple;
	bh=abpzgPcE0tClxTTnJrrnJs81KOD53MlzjqO6y5O1u4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dIT1w6tHUaT2PMnyHPJELrxKFDOl491Io2q3HFCk0bE0sl3sclHAUkJiHC1fYFXRw1l+dILS+ZnKobAAqPp/qghDWDbnp22QjnCtCm3cBXZnH5Ovs5M5pUDFv4Oc6WllKvBCV3XXpP1Gc2JguI2QiXPt/lg5x81dMtLoZFKWQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa6bcd7b3so449382139f.2
        for <linux-can@vger.kernel.org>; Mon, 04 Nov 2024 00:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710224; x=1731315024;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZsHnwYK/Q8ued/GJkpPndJ8wZEFcqomrGeEB2XCGVs=;
        b=cD0O3ogQ0oaSRtEiHSEgI0oOE3RP0ise/8PijbUUZMHets1xYMl0PzsIwEyTrhf0c6
         KmNBuv3CEXhELrjyNnPWsvtnTc4iiWyQrZV8gKZ17kUjAzShzdcsIedfNrpIHMTjCok+
         RyLsRrixjveDgVBSW0pwvvRz9Ee8k1RSnfRcyM/COIDD+Kpvzu+mGZLFPuBGgSQtLGzW
         nQEeSD2fe69K4Mwg+OuTUVcSIMZWtTdG2AMlpvcYrJinp6ucyrRdDqp8KfmZkNDXkdiC
         5xqahL3/MfWljQk188ylUn3saxYUnlggchx/5UdBt5AMNOA4d0C7C/+QrNlAjWR27Rga
         nwsQ==
X-Gm-Message-State: AOJu0Yw03JJ7mAF05tjoB7HzPXWdZJQCSm6fxmhUvMIt/vYlzCC4TgyR
	1btN5cSbhePqnW5yWY0b9HZ8zBSDIDVbypMeB/jWC2dzE2Lsmz/O39nZ94TEIvtaVXzN0pTCJrV
	A1wQ/44KDqKQ7Qs1CZxoe6uGLIE2eGPojPDnPgQwsIiopTSp4d4n5dqw=
X-Google-Smtp-Source: AGHT+IFqjFvRIGqFys7UL3sZzgrR6TeYpNnX/ESfI03l++OvjzdNvdy2RzHquIyZbne1L6pMIZ4VCzNhCnd9sboeguwi1pxU+yda
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3a6:af3c:56ae with SMTP id
 e9e14a558f8ab-3a6b02cf905mr92223925ab.11.1730710224161; Mon, 04 Nov 2024
 00:50:24 -0800 (PST)
Date: Mon, 04 Nov 2024 00:50:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67288ad0.050a0220.35b515.01b7.GAE@google.com>
Subject: [syzbot] Monthly can report (Nov 2024)
From: syzbot <syzbot+list9fa5fba6c1580c496e3a@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 53 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7872    Yes   WARNING: refcount bug in j1939_session_put
                  https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
<2> 4947    Yes   WARNING: refcount bug in sk_skb_reason_drop
                  https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
<3> 3045    Yes   WARNING: refcount bug in j1939_xtp_rx_cts
                  https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
<4> 523     Yes   WARNING: refcount bug in get_taint (2)
                  https://syzkaller.appspot.com/bug?extid=72d3b151aacf9fa74455

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

