Return-Path: <linux-can+bounces-3041-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39167A5990F
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 16:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0C23A28DA
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751B19D8A9;
	Mon, 10 Mar 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fy1HC0Tb"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EF1E49F
	for <linux-can@vger.kernel.org>; Mon, 10 Mar 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619166; cv=none; b=Sd9BUL97lXyllgucYzRv4G62rZ3DWqJ1BQ1wNx6hm4tIqASL34aMfYmcVLzwbYtTk0n9padDxCG5DmBF5g0POQHFzez6/tnF8BlMrpBuD61I9kXeF/LlaLd04hdihiLXMq8hZyrLrLrxZzx9ODFw/dqSuF34CfgjEjqzQ/KaL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619166; c=relaxed/simple;
	bh=hIPbtxydJBonDRqc+f0/Aa7T8/aa3kQFbNKPZD0pkNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRRN5KZEfg24jF7bfp05csc619rzJJgXTHSe0YlGDlW2XFXhSUaj0/FFLKJRybdORUGmQdrXdDYgBv+3ig2cXmpFNP1YK310Xu+HyKBdvywAoLytO8s8OW4Ms6xbBURJzRQHayDdqUKwN5v4olui0Q6Eq26LUHqfu3qYGm4nPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fy1HC0Tb; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by smtp.orange.fr with ESMTPSA
	id regUtsRZ9SBOtregXtcOVi; Mon, 10 Mar 2025 16:04:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741619093;
	bh=hIPbtxydJBonDRqc+f0/Aa7T8/aa3kQFbNKPZD0pkNM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=fy1HC0TbBRokrCrMXAVy/PgqPvmHItBB1X9n7OzgrI/y+5aRQQhn03ll79rnY+/Fv
	 uTb3QHXGgl9veBmvUSSOJueIdhGS9zWXBXdGQxkfYg7va6WZW+x9ii9pD72RQgAW5I
	 cq2XXNrazSrQFYr3WKRy5tQvf0Vu4Law+A2/g0Xo+Vj2EUussiKlykg4yh3fGS4HD/
	 h+m9ZbiyUPfjdoCl/HmgLFm5Hve3dI9RflBU+ifx6+BtuX32+kdWaiJGVVOfPBtQ9r
	 N+T3COx/55NthdFdNxzxFvIL4MY7FwGKSE6QJJbAHdjUKUudLcOvKdD3ViUL9mJ6rd
	 SwWuWzy34gfFw==
X-ME-Helo: mail-ej1-f47.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 10 Mar 2025 16:04:53 +0100
X-ME-IP: 209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf615d5f31so858657366b.2
        for <linux-can@vger.kernel.org>; Mon, 10 Mar 2025 08:04:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxgrjpoiCcPl6u5jUQls2IIcraqvQcFhoGi4APmZ0YOzCoR05ov
	qD8kVtS8OK593mmm4izoN+rOStrDWXcyigrT6DDvMzOZG9Y9duXFIGPw35370SwfY7J1cQh5Y6x
	h+8Uu3qvwzbcm5F7sQCOkItt5XHk=
X-Google-Smtp-Source: AGHT+IGk+h7Gbu/N61BIElhZJe9llj1zsZpV2NqyWl5xjgwgPq6FOJ+r7dD/NBBI5QYdqdCBNZsaxuhhEdtkOK8ByYY=
X-Received: by 2002:a17:907:2d90:b0:abf:6264:a624 with SMTP id
 a640c23a62f3a-ac2526e682cmr1377286266b.32.1741619089878; Mon, 10 Mar 2025
 08:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310143353.3242-1-socketcan@hartkopp.net>
In-Reply-To: <20250310143353.3242-1-socketcan@hartkopp.net>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 11 Mar 2025 00:04:37 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+iMQcXZ1Q7aDa0gSCqY64n6CqROk9spbbweynF59QZjQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jqujv_xa-t3uW9-NHcpVAhVrEbN_oVv2u8t6uGfFQ21KPbU57J-0qPqWCw
Message-ID: <CAMZ6Rq+iMQcXZ1Q7aDa0gSCqY64n6CqROk9spbbweynF59QZjQ@mail.gmail.com>
Subject: Re: [PATCH] can: statistics: use atomic access in hot path
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon. 10 Mar 2025 =C3=A0 23:34, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:
> In can_send() and can_receive() CAN messages and CAN filter matches are
> counted to be visible in the CAN procfs files.
>
> KCSAN detected a data race within can_send() when two CAN frames have
> been generated by a timer event writing to the same CAN netdevice at the
> same time. Use atomic operations to access the statistics in the hot path
> to fix the KCSAN complaint.
>
> Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com

Maybe add a Fixes: tag?

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Notwithstanding of above remark:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol

