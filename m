Return-Path: <linux-can+bounces-382-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDA87A77C
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 13:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588431C22204
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2783405C7;
	Wed, 13 Mar 2024 12:23:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571243FE54
	for <linux-can@vger.kernel.org>; Wed, 13 Mar 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332586; cv=none; b=Ci1HceAkSU9K/2g95X+oR8Txw7x0D7OWO+4CiFBLPPaqXn539xtbfxGBunLDH0gaF2oShT+/aRwHzWgGWsm6doUxm29X/276wc/b4Ro8XzwQqLVbRXujRrdlSuTZvvbXJCNZn9qthwzAh0QtveqLni7GW6YGsRJLinr1BN4YbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332586; c=relaxed/simple;
	bh=CMx0+K0+od6gAAfqGFuKrClz/7QMgfg21jkqF8+bk0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FkT/WnIL275lclgX1JU1r82rgQXZmCac/U3iFuVY/BGyRQMvHwZwyYmXietxVHsZnpi/EJ3IZESdrEiBXzVSmffXhsY3FaAIAbqvsumUGwCQp3l7LyA0TV0htZiWmbQiaCpbpJPNgrZd7LRUyJzUA06Qkbpy6ekojPAcrqbUF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c88a694b46so593529039f.1
        for <linux-can@vger.kernel.org>; Wed, 13 Mar 2024 05:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710332584; x=1710937384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/RQ7ulMJ/8EuK5QcToN/BsgCLIW1fJL8XxtmY+wQjs=;
        b=QFJWqNxKecBlGzG+IbJ8oSf6D0hoWcjjzFHNlcFGp31vkxiqG6ywBvJftBES7FUjO+
         qVnZIHgbRqFY/MdNBmXesUVFhNzCVpwSBhAes2hdxiNQ+/mNEV/6n+y1cgyMrrrM9SW9
         wHa2pd8Rc/oRtlUogT7wO4msaEu7egreveAFoZ5QV/Sspp9JS4lOhbQB6U8DgTuR53Yu
         TJPw6TraBxb77Wt5lGT9jk0jbc6N4625EFGZ8+ywIognJB5kiIaA1JS+hE7+sbv0CVAP
         r7+qKZAJ1Kav/J7QUJnwKiN1FUjD1CbXxqdVApugCTJMUyG2YusDJCPuBnoZ7XbunCPv
         FmuA==
X-Forwarded-Encrypted: i=1; AJvYcCUeHqNwqyyo5xng6Dz9y4GI9KQGRq8uLf7X5v1cceE4LLhHScMS4CfL6Ap/r+B5CDis7OcX9eFDdpIQevtlXhgKHN67bAzatMgc
X-Gm-Message-State: AOJu0YyirRaOrCNsJRjaZpdqMhCDvqXnuEUUDDqwIhoYfRiScvD2bd1j
	MQ/K0GBxIfj3UkCMjOgHU9BavMC3/qCLVknGKyqkdcIdN0W0/ZLqQzLd9AYkHKT7iT0y/3kz2fk
	fpthgT+jPvTvdnsd5wEabgR+qpMeCBwf1URolT5sb2hgA3aDdHLeLHKc=
X-Google-Smtp-Source: AGHT+IGVTtQ4uojG97WNJ0uwB0YBDq59+qtV5IZ/3cDnbc7YourhmR/GosPslCuD+dZwEelAMVRAygeYYtaFyq8wBk2Nc0aMcF63
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1693:b0:7c8:bd8e:a88 with SMTP id
 s19-20020a056602169300b007c8bd8e0a88mr143010iow.4.1710332584607; Wed, 13 Mar
 2024 05:23:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 05:23:04 -0700
In-Reply-To: <00000000000095640f05cb78af37@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002755ce061389d67b@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_queue_drop_all
From: syzbot <syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com>
To: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6cdedc18ba7b9dacc36466e27e3267d201948c8d
Author: Ziqi Zhao <astrajoan@yahoo.com>
Date:   Fri Jul 21 16:22:26 2023 +0000

    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10e4d371180000
start commit:   dd72f9c7e512 Merge tag 'spi-fix-v6-6-rc4' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=12abf4cc4f802b24
dashboard link: https://syzkaller.appspot.com/bug?extid=3bd970a1887812621b4c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17602089680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13398a9d680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

