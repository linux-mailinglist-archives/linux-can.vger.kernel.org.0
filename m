Return-Path: <linux-can+bounces-5663-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCDCC8747A
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EA233531BC
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF02FDC4B;
	Tue, 25 Nov 2025 21:57:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF462D23BC
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107824; cv=none; b=PyBg202CZsvVFWmlBGO+7XR/A9UpAI98xqsvdDg0UOvt6hdaz3zeh6NVBQnttkFAzwsYgzhBtCvtVAIdJjcPviJISsD3U76+dF9ab7Af4x47r7fe2S6cbTiCgs27nDr4ZX6eOm+yVDQgg7L/xKz2ypGQQazqpCzSPfHp9CwLO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107824; c=relaxed/simple;
	bh=/2HDgATv3ct8ZJWOt0qr5TSE8QGRIX3SoHWTcWoS5u0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tzkt37pebJyKCjTM65vI9Ep+I39ZjROq8HSYllzKwhRN2HfVeyVb7QZYROxrHWJrHoeigA35SAIeG9zFuFHrmrWtOVLNBfyVvv5PFUdmLaAQMX4lFArv6z5DDSxpNaqomu3walBUZdUVOP3JCDhXE3AY1Kk/5oMRtnnHDnkb/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-434a83cd402so58901305ab.3
        for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 13:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764107822; x=1764712622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT+4XkWR7efaDH0BcJaZyxh+BxXocscIcRlgONxMTWw=;
        b=lxbVuDCNdcVqxiZiA1D0rZXao39EMAQ9c5ObLzJjAS0OufJMphGw9QG43vgW9Xxs+7
         PHNgkClsGyad3z3jy21KrlS92XZC+spA4bGN3cP4P9zSwe2i0si/wyI/3t9oONC8izhX
         831L54mrFO9+NXRro7pFyscKrZvbSKcmyoLbrBeMbnF5s2khI2Cz3ihi5VWWWSeVeKf8
         c48sDNeX4RGzy9eKLCQ8UPSw63WJxwBlcS8sBbtFLgeGvYdBxucU+QM2SSkivF7u0ZUf
         AtlE08BacSMNrnG0vPQyvZ0ULBcMBxj9z/L9J/5TfvgpT/vr7htTwIzZI08vT4cyOX8I
         J7rQ==
X-Gm-Message-State: AOJu0YxrAm5crJKW2FIWfmyRzTOX/gyg1/JJeUcfx+xp9S11faEbp5q/
	r7RCOjDbK7x0AX+8sIb2pn8KRb7agtZcNbmMSclXNwTbqO4yx529RQEfVL8xq7xvpae/rLo8mt3
	Nr5Hsdx7Y+uIydGbyft7VbVglK7fMHt9dHfDomqhRjmsqI3xGDE6oMJVOxxA=
X-Google-Smtp-Source: AGHT+IG3wqjvbKfB2hfB4MeW4puzDDSRkS/RKgAh9Rbe/CaU1DCK2BO1zOrnYry0L1ycMdJdMU6YEb2LFZJVDVeXRJ3lnzUO1OIA
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a07:b0:433:2eec:66f7 with SMTP id
 e9e14a558f8ab-435dd065403mr35481365ab.15.1764107822418; Tue, 25 Nov 2025
 13:57:02 -0800 (PST)
Date: Tue, 25 Nov 2025 13:57:02 -0800
In-Reply-To: <9a2b03dc-acd0-467d-a4e6-feb5cf6165f9@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6926262e.a70a0220.d98e3.00c0.GAE@google.com>
Subject: Re: [syzbot] [net?] [can?] KMSAN: uninit-value in em_canid_match
From: syzbot <syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Tested-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com

Tested on:

commit:         30f09200 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13236e92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61a9bf3cc5d17a01
dashboard link: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1230257c580000

Note: testing is done by a robot and is best-effort only.

