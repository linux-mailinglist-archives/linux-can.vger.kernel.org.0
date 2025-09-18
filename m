Return-Path: <linux-can+bounces-4744-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD6B84B62
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 14:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470CD1C232C2
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861B0304969;
	Thu, 18 Sep 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXnGKhAL"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D2303CBE
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200328; cv=none; b=eCtthdvyB/vhWKv9JwgC6nGuDx6ZsU+p6/pMh4g9gxgEA/2e58Z3HR9rvqd2lOCUfZ+tzAAUPkiSRS5ktYJpVZ+p+4/gPTBG+xaN2bBPvyOkAcMZE/cT22oV8ZC7jsIpfyIJKMFjd+wTsnP2SlDbSOcfhA0zA9Fsbk87xNWklNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200328; c=relaxed/simple;
	bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LguCSHaosgSljiiYHdOeDle3GKkhhkisPt21kyVWGPsvE+gsAp4E/briEGbBgyy5dSTn0zz0728/Jr41slJdOEWDiV5KqfFOEEUEKSDj8H9o1FWrZEPbvEUtOCK9Erqo421DNPpGDvaPQDAlpfBjk97mE/NWaF09RU0xLlZKJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXnGKhAL; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso3926818a12.1
        for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758200325; x=1758805125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
        b=NXnGKhALfj6DlKeOHQ2Bg5ICvOLXQRL87q2c4Dyfau+W0hglTwwzaKOaqY507QyHnk
         9Ki6JEkZw+W8uT7xLGegNVOiM3eJsB4Qsfno57q+yr9fZEhK1DF72giefaYlvQnbRh4q
         T1bxVw5tDGdpoNO6bNIBIx8zPnlS61+y/zkFtld7loynoTEUfDnADlYz8fSqBMuGhpsR
         4imNkTluKLs0F4YMvhlWkf3xFjPiE6DOAv4yj/VlZdgGAyWQdtqMAI4zg3Uqnbqibm4l
         IZvoXM2f6DyscJIoOV3AnJdAiOJiz7VFf/Nd/fIqK8gmn59ywBUTodIKGvjbjP/rBw1W
         uNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200325; x=1758805125;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
        b=lI45VHFVNXiycATQJY9Vbi7bSNXvNJsmDwrWaHvEnaErcW1HveJNIL3zaxUaUGx6gZ
         tM33qM53ko67eKOIp43F5rLQ8a0DcD/hoqqWDyuF4Qy+gw+X2sJ+e3w/VFuH6FoCmC1N
         SoGQzPgqlIPo2pWeiNFJq8p22fuN+HVt5iDEcz6c1ajIls6zIUBHEK2BED9KdpDjSbma
         puCxTZuk+Ak4z3PVBoqE3Aek7Cc7ufCozdiwVQm26TxBuhXk1+pkNeyWE/NJwe0/MQaa
         z3YYdFVN3th63hH1kb5t86LdIYn+PrZ5HCdSfg2RlhssfdTcDJNYcCZ7/KkZTZ9KTQDp
         3DyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVksl1RHnm9lG/fqgcm9hYZgrxapW0QgURpv+q4NDshPHFjhiq0kG6J+AGBQjUg6UhY9n5RsMlHOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpprUQbakRr+QyJmFF2xpRqKnqe3XeKfjtCW3OmUKrkY1Q1vIh
	Nz/nGqirh6SGiyiNtx2D8zvvhl3tRu43VgaIfZHgLsKVBmFxsA2IbO2J56CsfvH1uHeO6gtkZwA
	5MCLF0BmuJooIdzZjIIfJVqN6GeaPHBc=
X-Gm-Gg: ASbGncsbsVuDkmlkMYQC7y73/nSSmYIRQGBEgSTJ85TGhMlLw6d9kOCZ1jlm+vBfXBM
	P48rjZF9/Nj6KPVcwO27Vzl6oENEgt2B/e2wNsZgkrzpmRmWqC9DtdnvrUTFwpTl1VH4OUteey3
	gg+upEma/GlgoPf1FvGmdZVR1cWy9N5Gsv5ou719TC3RtB/HICBHFT8iyU0yWO9d1BgspO+HKdz
	NEuZy1jcjFSQVc9/kYGgdFOJA==
X-Google-Smtp-Source: AGHT+IHG8sk3bcUaHQwBrZoLncnJChfwaJcuvBt6nfYyVTZWygm5etjUbCmo0srSUZFjiTWBAdZCH1hJ4cgs9M5FLD4=
X-Received: by 2002:a17:907:6d06:b0:b0d:400:9182 with SMTP id
 a640c23a62f3a-b1fac4e0b80mr343825666b.22.1758200324771; Thu, 18 Sep 2025
 05:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Thu, 18 Sep 2025 20:58:33 +0800
X-Gm-Features: AS18NWCEXBGAyDTuAdYfLyOIr8P8xtqgcUaqAsI0KK0ysqpeO0oKN9Ycaxuqg4o
Message-ID: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
Subject: Possible race condition of the rockchip_canfd driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

I'm using the rockchip_canfd driver on an RK3568. When under high bus
load, I get
the following logs [1] in rkcanfd_tx_tail_is_eff, and the CAN bus is unable to
communicate properly under this condition. The exact cause is currently not
entirely clear, and it's not reliably reproducible.

In the logs we can spot some strange points:

1. Line 24, tx_head == tx_tail. This should have been rejected by the if
(!rkcanfd_get_tx_pending) clause.

2. Line 26, the last bit of priv->tx_tail (0x0185dbb3) is 1. This means that the
tx_tail should be 1, because rkcanfd_get_tx_tail is essentially mod the
priv->tx_tail by two. But the printed tx_tail is 0.

I believe these problems could mean that the code is suffering from some race
condition. It seems that, in the whole IRQ processing chain of the driver,
there's no lock protection. Maybe some IRQ happens within the execution of
rkcanfd_tx_tail_is_eff, and touches the state of the tx_head and tx_tail?

Could you please have a look at the code, and check if some locking is needed?

[1]: https://pastebin.com/R7uuEKEz

