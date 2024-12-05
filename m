Return-Path: <linux-can+bounces-2343-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8187E9E5D71
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2024 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E61283FA2
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2024 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BFE22147B;
	Thu,  5 Dec 2024 17:40:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306521C16C
	for <linux-can@vger.kernel.org>; Thu,  5 Dec 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420428; cv=none; b=pH7sdwHZMxdgScjVVk43rbM8maENdNonjAoxxHopv7KbV4qumHEfkUrhSUM1b+3o5FYu/uVyO9Ll171OzMcfPS6c00CvE8BU4N8Og2Yq4K+r7cW6si2CDa60ek1e8VoXh5+1V6kUn0/0SOdPKzE0kHp3UJgsDgIFhOaccbEIg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420428; c=relaxed/simple;
	bh=ckqNK1kFj0hOrtGRecbfTqUnXzQvUTv259nme0vqwJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qshNHtXQSfzGT/YgRO/6crH2mzYZZLQLkn9k+ekq8KQNzPrVo5k9SBhfJJSphJntZeiGrYaeh748NVtrPOtL0sJH9QaYRkQwLqcNMeJA00RZj27doZaVjxfWGDTQ7XqYFsioz1zlG5BF3FtBCT2uP6010Sq/4dmkCfGwgHes8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so21304365ab.3
        for <linux-can@vger.kernel.org>; Thu, 05 Dec 2024 09:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420425; x=1734025225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nai+Q+yfGAvS8Ho7NPZXJwCDRmVEaZXI5r28mNwpuR8=;
        b=qCbYsy1p9GXDeetlnfvug1ixB5PhAICQNensqqBVuC7uZ3+Ni1JzQPyd+QQDegPPsm
         TAglLWyKnqeVYid3I3pkc9/avIYYQh86xZrkt7MKu9hhCpRLItiTfGLoalig2AQoQ1U7
         Wzx9xnxI8afYp+d/Bk+PXlcYttd6JxhqNQMlzqlwvJ4W5nK+cdOsDMTncv/HdyY7G77+
         tj3bJzKqlEnhO/GketxIHakorZQTxqrjt2SKy7TQ1g1n5ojMHyXB4fdJz5xsuSNkNzlb
         RhGz++D+AdNQZqfsSz61ZyENLz8wzgSeDhv0UB7QBPvn2cQlcNPGeyc07vBP5ezTrMlN
         dM+w==
X-Gm-Message-State: AOJu0YxWAUPWfDT2yy3HMwa1CDzdU9iy50/wB3+8XzNxsrrF+Wrrlgxi
	BeIlCpn5rTOjIRjHC7Lc8FbuM3yxIRC7BxS9SCNE2V/7kSYS9UCShRDVo0zYxEriqu+6rO5rCoy
	ofzzWwmtOfcJKwwj6H9OO0GxMlvGBeXtfo5GzgMaV6YbMELXt5VDTiCs=
X-Google-Smtp-Source: AGHT+IFNSNJODWIXbQ394i760sPr6Swl9ckSzqmuHfxCrUVLJz0zVWAEEbVAdJHq/dCMhu2HIigm8ONaBH4FXzvnb8+lzMbUAPaK
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:e0e6:65a5 with SMTP id
 e9e14a558f8ab-3a811d94896mr2864845ab.6.1733420425764; Thu, 05 Dec 2024
 09:40:25 -0800 (PST)
Date: Thu, 05 Dec 2024 09:40:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751e589.050a0220.b4160.01de.GAE@google.com>
Subject: [syzbot] Monthly can report (Dec 2024)
From: syzbot <syzbot+listef3aa534c94f9b108626@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 53 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11504   Yes   WARNING: refcount bug in j1939_session_put
                  https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
<2> 3437    Yes   WARNING: refcount bug in j1939_xtp_rx_cts
                  https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
<3> 671     Yes   WARNING: refcount bug in get_taint (2)
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

