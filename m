Return-Path: <linux-can+bounces-1593-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690C990095
	for <lists+linux-can@lfdr.de>; Fri,  4 Oct 2024 12:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2527FB25E0B
	for <lists+linux-can@lfdr.de>; Fri,  4 Oct 2024 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084214A605;
	Fri,  4 Oct 2024 10:11:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20114A0B3
	for <linux-can@vger.kernel.org>; Fri,  4 Oct 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036686; cv=none; b=m58N0RHcemRrDA1t1cATr+EIQOumjmM5KAEfhOkEsoUn5wKxUTjXc5/D085uz9zxJ0vB9FgZgCEPMDAMghBtNrcXlBfAnZNUR9DkaPP27Loezv6IoAphmy8F3BFnDnWovWNj1VcJOYsfj6Ex8PnS4CmWl5AfLnw7Ev1Emkb60CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036686; c=relaxed/simple;
	bh=x2O7TS00RicfPt6G+WI0X138zcI334CP9Dx2o5AECSg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aIyBa7N2VtfTUZ5PYYgeEHjE0YuN90p+4okWD/qTUGVfJk/diXfuoJhxM8fWH5XKpy5RaDhP+/77pL4S/6dylLqIOQIpp+RmP0nI5GBdUOCIzB7aD97GmB65ZS/S+fWSv4dF8uYz+siNUdr44O/2xceOv/OwPUkmCWhb4XDL+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cea2c4e35so247828939f.3
        for <linux-can@vger.kernel.org>; Fri, 04 Oct 2024 03:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036684; x=1728641484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgrEqgbT4gTBIvHYHiHmpH8MQDGJqj6FO+l00kf1JG4=;
        b=WuyhwnKkXxDjfXH5dMjd9Ai2/l5a8qgcc/7FTN2KNZUjMWeRdcv4a6Jlb00qVLUvjR
         Y2HkXS0gjsZkGm93dbotp2vSw0GiPsBSHGwEBNlleENkDccKcP9q1+WDXHXE8BxLKCSc
         /dd9A+b3+Ghjjl6loB7tMCIau1kJYfFkFHcPL8IcBRYx3D9k04mySM+y/iYqY+g+Nq9j
         DpK6caq/evOc3wkBvMzb2qWIk7o2eOgFs44ySZxrpklsvaWCHesDeCvZzNerzJUaICwJ
         VCqq7/ID8gr/GYgqO0BTHTso9qnTWCNc4nDZGEvXDbXIsRjPyPayfqQ35SMlRMVExvCn
         wLOQ==
X-Gm-Message-State: AOJu0Yzd+vckNCow0mvT83ALpeDgb24QCWqjeCn2dkyYEUH+NjKC+60J
	gHhcIbpVKeDpmOSmai6WK0t50H7JKjRCdFI/Pay0oBNx7ruXehGxjl8sT+VwH3jL0XJHsZOUq6Y
	eHWJ1cp7MHpYPHUgSdArpfv1KUGxAjTPRV5PM5FK2RFntjQmX+YoPp+Y=
X-Google-Smtp-Source: AGHT+IEgF5qLKJShXi+y0+519ebwQbROqt63ZqpT+BMHXJSu3IlAa1Ve+1roHFw52YWzrTjljzxhlo4344nJtZBgasj5o0CIA5MH
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:8d2f:2914 with SMTP id
 e9e14a558f8ab-3a375bd4f33mr21615385ab.23.1728036684412; Fri, 04 Oct 2024
 03:11:24 -0700 (PDT)
Date: Fri, 04 Oct 2024 03:11:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ffbf4c.050a0220.49194.0485.GAE@google.com>
Subject: [syzbot] Monthly can report (Oct 2024)
From: syzbot <syzbot+list142a88e98c5a6a6358e7@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 1 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 53 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4408    Yes   WARNING: refcount bug in j1939_session_put
                  https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
<2> 2347    Yes   WARNING: refcount bug in j1939_xtp_rx_cts
                  https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
<3> 2184    Yes   WARNING: refcount bug in sk_skb_reason_drop
                  https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

