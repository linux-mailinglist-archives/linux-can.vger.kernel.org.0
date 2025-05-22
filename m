Return-Path: <linux-can+bounces-3627-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4046BAC062A
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B883BE4BD
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9C24E4B3;
	Thu, 22 May 2025 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ri6YzF+7"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DE24E014;
	Thu, 22 May 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900318; cv=none; b=RyfjEWiQ+JvhLyFfCfKjY1T6ySzQSrxjDLXF5VcHjStI8o/5J/CRkHpEtVVjRA57fri4yP3WVO2RfrFuKut0PPJn96QX1WeRWpL796Wdp2J+sLS+oLVdrIZYOsCkF2V3L7olkottUs3b8dzi4SjeFfUQFUfj+aTlLBdZq+C9yF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900318; c=relaxed/simple;
	bh=K1Ju9ChBoPJtQqkm13X9ek0t/vFqTZS0ihzaKbzH1mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIm/Plq2/Tzt27x46UjcWnLI1ArhCEWf4pQMDO4/EXt2WdRjRycwHCZhGCWngvgxmcSGdpsEWR48a8pzyG6AwMwZ3/GobDsDwqIQtGNThOUEBhVvA15WNHXk/3Cw+INdR8yD5sD2xfHRkh/pXsycDK1KN7vbgfXUZ9tErKDYnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ri6YzF+7; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by smtp.orange.fr with ESMTPA
	id I0iWud0W2MqmCI0iWu8Y86; Thu, 22 May 2025 09:51:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747900312;
	bh=K1Ju9ChBoPJtQqkm13X9ek0t/vFqTZS0ihzaKbzH1mE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=ri6YzF+7GstVZB0kzcCkrFZ75d1ioyyvh3/A+wP4virKKkiouaG5/8wwzTeRWCFc6
	 WL1VFRf3YzNNkSqIaW3cdb2bb4punx1k37y2w6qw1TOo9OK2BKcBYkeDo8/wXQ4Z9z
	 8Lw2fo1+p8ye5c0qJw9/Be2nknj/qkvlmXLHI6R5dqP3YeLu7KdIzH9lE05MPYqgrz
	 AKhPZFf84WuGdgnUfMlkCEKLQuViOrshvZcxe79ZU6R5qP7PozJ99WSLunDJPi58KQ
	 i3jxDcukf5l5NZgT4cAvk/ZxS3c+WswQypz7TBTA6p1wSSQD2o+aB3PzDQkVetOYny
	 HrnuXVily4How==
X-ME-Helo: mail-ej1-f49.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 22 May 2025 09:51:52 +0200
X-ME-IP: 209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad5574b59c0so885981166b.2;
        Thu, 22 May 2025 00:51:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVepbA7txDmo3AqUEe6Lyn4DhQ2fHGq0HyWwjEn8CFh1lNu99ICaWD5Yc5WtPfbKa2ewvgo+yeEiMnvlCve@vger.kernel.org, AJvYcCWy24wDbms+a9TFohKAHPAWXe5LtgCZXVLEL0q39vr+h9IqMyZWzQBGJyezcppul9/M3JP2oOahStn1@vger.kernel.org, AJvYcCX1uaIgzwk9VoJIEfkZffS9pgk9xeeP7TQjefjVcwzsEu7Xo6i2tQrShbwujUx4ZBDNKZERiBEm/k2x@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJ/GPxiciOFddTn2js5e4o4i7ATk13mj3v0qjgxSdqftLT/W+
	wsyD/ouqO+7YepzGwS8OimtkK3MhmTcz8cde0Yq37LJzK6bSBe409Fsk9uHcYL0Bhdf4igAf9CG
	6httQu4Mp82lLrD0UwCsGm3E3fHMhdM4=
X-Google-Smtp-Source: AGHT+IH+G1RV6f4XSiIEPdRrb6TPdOE7pGKLKdSwxOPEVBL4YFwSKpBYuEYJEJFRYIUgbOU8zKhMjLiGuFzdQ8+OFcE=
X-Received: by 2002:a17:907:7252:b0:ad2:39f2:3aa8 with SMTP id
 a640c23a62f3a-ad536f9d574mr2255053666b.38.1747900312547; Thu, 22 May 2025
 00:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522063232.2197432-1-zhangqing@rock-chips.com> <20250522063232.2197432-3-zhangqing@rock-chips.com>
In-Reply-To: <20250522063232.2197432-3-zhangqing@rock-chips.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 22 May 2025 16:51:40 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJzR6ucRnCHFq8ZFRnznRsFYq6BMQY24aaROJMLWigU4A@mail.gmail.com>
X-Gm-Features: AX0GCFswcIk3OPc4Qw6f7CtNFw58HMRmuvPUjxlDYToAYSRWrO6-0BPCSk3B_vg
Message-ID: <CAMZ6RqJzR6ucRnCHFq8ZFRnznRsFYq6BMQY24aaROJMLWigU4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] net: can: rockchip: add can for RK3576 Soc
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mkl@pengutronix.de, kernel@pengutronix.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, cl@rock-chips.com, 
	kever.yang@rock-chips.com, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu. 22 May 2025 at 15:38, Elaine Zhang <zhangqing@rock-chips.com> wrote:
>
> Is new controller:
> Support CAN and CANFD protocol.
> Support Dma.

Please write a more verbose description with proper sentences.

> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

You need to break this into several patches and several files.

You can not put everything in rockchip_canfd-core.c. Create a
rockchip_rk3568.c in which you will move all the already existing
rk3568 specific functions. Then, in another patch, create a
rockchip_rk3576.c that will contain all the new code. Also adjust the
headers accordingly.


Yours sincerely,
Vincent Mailhol

