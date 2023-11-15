Return-Path: <linux-can+bounces-21-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C47EBC6A
	for <lists+linux-can@lfdr.de>; Wed, 15 Nov 2023 04:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DAC1F260A6
	for <lists+linux-can@lfdr.de>; Wed, 15 Nov 2023 03:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25707A55;
	Wed, 15 Nov 2023 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD964C
	for <linux-can@vger.kernel.org>; Wed, 15 Nov 2023 03:54:07 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79108C3
	for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 19:54:06 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c1b9860846so1472167a12.2
        for <linux-can@vger.kernel.org>; Tue, 14 Nov 2023 19:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700020446; x=1700625246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l61plfqF5nHarfz7jpK6i+deFeBGlZF1Gciyjaej1pU=;
        b=qMFdEUj3t9RddVByCz2zYJCqtCn3oAErujOJcO/dj/20gmUEBW2i7C3vnuZWKaca+M
         b6EoJcvQ1rgkd8/u3msfHk1Th8NfbCJmaKbrU6Ot0y5PnDABTM8ymkHiTsCDyIQx4uKr
         PWFgxKZtwqi1mAs2f+9y0tX1KLyZkVCX6MCeFtQZBAK7xRhDueM2Yh7tdIqZlYbTNjLX
         J7GiX1geSbC2QATks0PVL4kj4VUiRha2gVsq6OFwXZnYntaRitU8/Q2Gaxnp3F1zHicL
         S+JRhKQaP4IYl/LVspKTwX+V8rMDjcmRi21drcdCe8FSwjFaVeINXuM6C41RPm6pOD2M
         Uofw==
X-Gm-Message-State: AOJu0YwiO4wU14/juiGGwJiYMd+nHknVzqAz/vRzUNzmckeHte4kszpE
	iC36Nygt6qFQsvev3iLH2Afyhq9D8V4+dKO64ZkVdh6dtMfD
X-Google-Smtp-Source: AGHT+IF7oCUwCwgZD8xczyFHrZBrkFObiOTryGSeBv2U1eTP1+U0YLkF1/pd5Ws0MaLMfr04sNagBgqsvJlTEqQVYDltsdAuSXeY
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a65:40c3:0:b0:5b9:63f2:e4cc with SMTP id
 u3-20020a6540c3000000b005b963f2e4ccmr1080000pgp.2.1700020446008; Tue, 14 Nov
 2023 19:54:06 -0800 (PST)
Date: Tue, 14 Nov 2023 19:54:05 -0800
In-Reply-To: <0000000000008981d905ffa345de@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb9c3d060a28dad8@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From: syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To: arnd@arndb.de, astrajoan@yahoo.com, bridge@lists.linux-foundation.org, 
	davem@davemloft.net, dvyukov@google.com, edumazet@google.com, 
	hdanton@sina.com, ivan.orlov0322@gmail.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, mudongliangabcd@gmail.com, 
	netdev@vger.kernel.org, nikolay@nvidia.com, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, roopa@nvidia.com, 
	skhan@linuxfoundation.org, socketcan@hartkopp.net, stephen@networkplumber.org, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2030043e616cab40f510299f09b636285e0a3678
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Fri May 21 11:57:20 2021 +0000

    can: j1939: fix Use-after-Free, hold skb ref while in use

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1438c947680000
start commit:   1b907d050735 Merge tag '6.7-rc-smb3-client-fixes-part2' of..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1638c947680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1238c947680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e7ba51eecd9cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fea8fb680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1633dc70e80000

Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
Fixes: 2030043e616c ("can: j1939: fix Use-after-Free, hold skb ref while in use")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

