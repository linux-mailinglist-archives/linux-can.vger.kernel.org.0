Return-Path: <linux-can+bounces-1630-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6499A544
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E008C285D5F
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE9218D71;
	Fri, 11 Oct 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6c7PbZo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A48804;
	Fri, 11 Oct 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654030; cv=none; b=QoHjVqqmzoq3Y3z4s5Vilfjk6Ko0cf9NsqAxm4Bqi8Mzt9SzFOEuVnqSSRzeS8hVQHo/3kwuR2/QqHIC6XG+20XVprryigImB0ol2P4IJIf0ygH+i1jk49dqjbZsREYVUDiRcOcZPp2FnZBfJTGJ9UiI4jURLV2H/E7pNlqer5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654030; c=relaxed/simple;
	bh=wgjfu5r3AaoQ1nJV2V26leGa8fLPEXaUsDW3S1EM/fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFYzvsRsUodUXL0WLuiaJ/1IlaYUcFIfrAU0ZAJYybidSGiGRdVt/z2D1e3wgGmTluvn7wHrkhHEOMvQiTjyV/EJZa3J+J7U4LTxiIH3mpfCxVYdRbQn4ZuMpbCgQnNfWo/7Xb8VBAuwOTRmHGmtITa7VTtlpl7wXrtEX/f7V4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6c7PbZo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539d0929f20so1237694e87.0;
        Fri, 11 Oct 2024 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728654026; x=1729258826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0ZkUoJvRjLXyfZrkGYuzTLNlYvy7Oqnuq8aLsm5+ho=;
        b=V6c7PbZo2yjd0bZIeh0HaBWK99ylwjDII8r53QkAwNJIkNzfVrVbtoXdshBbWEcElS
         DunR87zF6YRMbrKGHwYTAKX7+ZFeTFNqN0UVH5JZ/VpQThcIem3kfDY0KMC/2V30/0wR
         MPOU08RMeqEHZxyza4iPqZOtn4WvJbG9ikywwKAXEa83ervfX3ZXYM+Td4epCN6CLw/R
         CaUdtB/t8H8Uzw4FbusVe28ZdqRifExzhKHYvhYAKJkt5zzHdjAKe+3TZ0FEHOykNObh
         od3SF7KqheLmpcv7/3xncZwVl6sNTrtUuknbhSYmuItsYeOKU7iDqeJP0mACBAGcCUiO
         YTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654026; x=1729258826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0ZkUoJvRjLXyfZrkGYuzTLNlYvy7Oqnuq8aLsm5+ho=;
        b=N7HoSaqbeiz1QhPzhlo1ZP5/UWs2A47TJIScSVVH5X1/3h4eQE8rQrep9ClkmKaBOz
         0gEBwoe3Ttj7qnP8D3DUZame9zD7O5+iDoY4+t7pUmxPE+gNdA7I0FKjMWl0TjIoVSxv
         UU/p1gICjPVtRaOoJI9rIfep+dT9vu+4uIwmWk2qSO5EB724xnI+d4wIM7xWZB9Pd9zR
         oxBnGFVfvDds3QiYd/Y1vBaod5Iv9H5PnGvb7+BPJj81TmuHLrKj+D+eP1D/lkkBHIFg
         nu9po/HUdcxJVsgPRrJGsb9pRyqNcu81u3TJT6hU9b+dsULUSRgVJSvGx5n8oTx7WMKX
         gRRw==
X-Forwarded-Encrypted: i=1; AJvYcCUZFzsIDPqYaxpKDx2DJyfNRiHQJV4FTJT5JwXbqzHo1zVzWEo+VIjW9qbA5j8C8k2DQqwzMyTs@vger.kernel.org, AJvYcCUZJAERKObQsBF6rqVYIjzrhUCthStfEzUA8pPtdCktbURFAnVnBYe9M9v08R++drhrV4riRjzYLJy4BJLm@vger.kernel.org, AJvYcCXeAXiIWpnwT9HT/xvS8D/wUOhZ+/aZVN7Ll+WmVyXNkmULNHVqL8LNfZsxPcvH3myszVlWhz3SUQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdhy7h7sWWpH1lRN/Nq+VH4yby0qE1v6HT5Nfs1ErENLwPEwEr
	ROvIk4z+hhalczB/D8+WNXNO5AqOSDB7+iXpLUSnjqU0syruai+E
X-Google-Smtp-Source: AGHT+IGYbIPQBrWgRbvQaCx70aNq3oHv3T9A2i8xbZOrNifAHVoPr97Fosunh1fB0lmSO7qui2klhw==
X-Received: by 2002:a05:6512:230f:b0:539:8dde:903e with SMTP id 2adb3069b0e04-539c98ab8a8mr2403029e87.22.1728654026130;
        Fri, 11 Oct 2024 06:40:26 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c87fdsm604781e87.81.2024.10.11.06.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:40:25 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: eadavis@qq.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
	leitao@debian.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	robin@protonic.nl,
	socketcan@hartkopp.net,
	syzbot+ad601904231505ad6617@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	snovitoll@gmail.com
Subject: Re: [PATCH net-next V2] can: j1939: fix uaf warning in j1939_session_destroy
Date: Fri, 11 Oct 2024 18:41:24 +0500
Message-Id: <20241011134124.3048936-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_5B8967E03C7737A897DA36604A8A75DB7709@qq.com>
References: <tencent_5B8967E03C7737A897DA36604A8A75DB7709@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Aug 2024 19:07:55 +0800, Edward Adam Davis wrote:
> On Thu, 8 Aug 2024 09:49:18 +0200, Oleksij Rempel wrote:
> > > the skb to the queue and increase the skb reference count through it.
> > > 
> > > Reported-and-tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > 
> > This patch breaks j1939.
> > The issue can be reproduced by running following commands:
> I tried to reproduce the problem using the following command, but was 
> unsuccessful. Prompt me to install j1939cat and j1939acd, and there are
> some other errors.
> 
> Can you share the logs from when you reproduced the problem?

Hello,

Here is the log of can-tests/j1939/run_all.sh:

# ip link add type vcan
# ip l s dev vcan0 up
# ./run_all.sh vcan0 vcan0
##############################################
run: j1939_ac_100k_dual_can.sh
generate random data for the test
1+0 records in
1+0 records out
102400 bytes (102 kB, 100 KiB) copied, 0.00191192 s, 53.6 MB/s
start j1939acd and j1939cat on vcan0
8321
8323
start j1939acd and j1939cat on vcan0
[  132.211317][ T8326] vcan0: tx drop: invalid sa for name 0x0000000011223340
j1939cat: j1939cat_send_one: transfer error: -99: Cannot assign requested address

It fails here:
https://github.com/linux-can/can-tests/blob/master/j1939/j1939_ac_100k_dual_can.sh#L70

The error message is printed in this condition:
https://elixir.bootlin.com/linux/v6.12-rc2/source/net/can/j1939/address-claim.c#L104-L108

I've applied your patch on the current 6.12.0-rc2 and the syzkaller C repro
doesn't trigger WARNING uaf, refcount anymore though.

== Offtopic:
I wonder if can-tests/j1939 should be refactored from shell to C tests in the
same linux-can/can-tests repository (or even migrate to KUnit tests)
to improve debugging, test coverage. I'd like to understand which syscalls
and params are used j1939cat and j1939acd utils -- currently, tracing with
strace and trace-cmd (ftrace).

> > git clone git@github.com:linux-can/can-tests.git
> > cd can-tests/j1939/
> > ip link add type vcan
> > ip l s dev vcan0 up
> > ./run_all.sh vcan0 vcan0


