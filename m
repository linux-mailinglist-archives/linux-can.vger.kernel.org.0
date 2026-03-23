Return-Path: <linux-can+bounces-7234-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMWTHzz3wWkmYgQAu9opvQ
	(envelope-from <linux-can+bounces-7234-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 03:30:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDB8301283
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 03:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDB0A30292D8
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3B38759B;
	Tue, 24 Mar 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RTFBubUc"
X-Original-To: linux-can@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E332B99E
	for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319408; cv=none; b=BqNe2u5Bxzzhxyd6f0IM7OGZD6nnjyPewAlXCzGfJmS3fvO5aJdt9TqcHAywUwabPuQ2zDyvdfwaQ0cU6xu9V5HJTo2GpXxyTBlLAJ1VdmqQq+ZMuglZpM5nOxogY3kIo6t8OYO1+EzkDDQ41V4CNLxgMJorhYkimHBLaX1MdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319408; c=relaxed/simple;
	bh=Vr+wLb3/yfuaY7Ek50G5tqooWQuxrr2KXAF3tU7VBDw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=BPubriYweOMdd9chHUaXAUzWFVGdjqIVXs1jzC73XFBzzm6DHTL3e9G/nMCcp8u8dqPXpzWyP25OcI7SIr1aL/QQE2xOZOCIJp1HYdlPHvkcl7SX7B5W/DD7EU0L+3NIxgEed1weJgvLae/DcJdz8hKbZM/7LwQwyYurAMa3+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RTFBubUc; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260324023002epoutp01b29e2940832da8621fcc2ec0be9b12fc~fphiSfDFn0287202872epoutp01i
	for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 02:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260324023002epoutp01b29e2940832da8621fcc2ec0be9b12fc~fphiSfDFn0287202872epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774319402;
	bh=xiEG8fs8U4waGFe76frAqj8GUGT8PfbUsJqfEpDU4H0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=RTFBubUceVdG5dBZjg2EJuOun+7AvU7K1xXJVOiY75v5S6AwPDX0GCIymngOFAphd
	 E4RA3K/kK+gtTKLgy3khdnDiPmc2cGWIz79uHvHB6IujWAiNQY1L9e+YM2hT5hM2cb
	 67/UCzZXuKEnGh+5DWuT53H601jKazX4GP44bHGA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260324023002epcas5p3c3a08032a55b26ba4a7023fdeaebf3cd~fphhsTMXr1327213272epcas5p3T;
	Tue, 24 Mar 2026 02:30:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ffvBx72xwz2SSKf; Tue, 24 Mar
	2026 02:30:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260323172713epcas5p4dd04df01adb71b7563e1cac14b927632~fiHlqRiPK1063110631epcas5p4A;
	Mon, 23 Mar 2026 17:27:13 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260323172656epsmtip1078ac64ab1a734cd90e8019874a7de3a~fiHV3p2Rc1639516395epsmtip1L;
	Mon, 23 Mar 2026 17:26:55 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Vladimir Oltean'" <vladimir.oltean@nxp.com>,
	<linux-phy@lists.infradead.org>
Cc: "'Vinod Koul'" <vkoul@kernel.org>, "'Neil Armstrong'"
	<neil.armstrong@linaro.org>, <dri-devel@lists.freedesktop.org>,
	<freedreno@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-can@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
	<spacemit@lists.linux.dev>, <UNGLinuxDriver@microchip.com>, "'Bart Van
 Assche'" <bvanassche@acm.org>, "'Peter Griffin'" <peter.griffin@linaro.org>,
	"'James E.J. Bottomley'" <James.Bottomley@HansenPartnership.com>, "'Martin
 K. Petersen'" <martin.petersen@oracle.com>, "'Krzysztof Kozlowski'"
	<krzk@kernel.org>, "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <20260319223241.1351137-10-vladimir.oltean@nxp.com>
Subject: RE: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
 struct phy guts
Date: Mon, 23 Mar 2026 22:56:51 +0530
Message-ID: <1891546521.01774319401971.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJoz1sM+EbPjkyDopxrfJVWkMJWdwIGLiEOAj0DJam0ghnJMA==
Content-Language: en-us
X-CMS-MailID: 20260323172713epcas5p4dd04df01adb71b7563e1cac14b927632
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260319223312epcas5p183a1e0c31206025da8cf00b5d745a0ce
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
	<CGME20260319223312epcas5p183a1e0c31206025da8cf00b5d745a0ce@epcas5p1.samsung.com>
	<20260319223241.1351137-10-vladimir.oltean@nxp.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7234-lists,linux-can=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alim.akhtar@samsung.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EBDB8301283
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

HI Vladimir,

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Friday, March 20, 2026 4:02 AM
> To: linux-phy@lists.infradead.org
> Cc: Vinod Koul <vkoul@kernel.org>; Neil Armstrong
> <neil.armstrong@linaro.org>; dri-devel@lists.freedesktop.org;
> freedreno@lists.freedesktop.org; linux-arm-kernel@lists.infradead.org;
> linux-arm-msm@vger.kernel.org; linux-can@vger.kernel.org; linux-
> gpio@vger.kernel.org; linux-ide@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-media@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-
> riscv@lists.infradead.org; linux-rockchip@lists.infradead.org;
linux-samsung-
> soc@vger.kernel.org; linux-scsi@vger.kernel.org;
linux-sunxi@lists.linux.dev;
> linux-tegra@vger.kernel.org; linux-usb@vger.kernel.org;
> netdev@vger.kernel.org; spacemit@lists.linux.dev;
> UNGLinuxDriver@microchip.com; Bart Van Assche <bvanassche@acm.org>;
> Alim Akhtar <alim.akhtar@samsung.com>; Peter Griffin
> <peter.griffin@linaro.org>; James E.J. Bottomley
> <James.Bottomley@HansenPartnership.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; Krzysztof Kozlowski <krzk@kernel.org>;
> Chanho Park <chanho61.park@samsung.com>
> Subject: [PATCH v5 phy-next 09/27] scsi: ufs: exynos: stop poking into
struct
> phy guts
> 
> The Exynos host controller driver is clearly a PHY consumer (gets the
> ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> to get the generic_phy->power_count.
> 
> The UFS core (specifically ufshcd_link_startup()) may call the variant
> operation exynos_ufs_pre_link() -> exynos_ufs_phy_init() multiple times if
> the link startup fails and needs to be retried.
> 
> However ufs-exynos shouldn't be doing what it's doing, i.e. looking at the
> generic_phy->power_count, because in the general sense of the API, a
> single Generic PHY may have multiple consumers. If ufs-exynos looks at
> generic_phy->power_count, there's no guarantee that this ufs-exynos
> instance is the one who previously bumped that power count. So it may be
> powering down the PHY on behalf of another consumer.
> 
> The correct way in which this should be handled is ufs-exynos should
> *remember* whether it has initialized and powered up the PHY before, and
> power it down during link retries. Not rely on the power_count (which,
btw,
> on the writer side is modified under &phy->mutex, but on the reader side
is
> accessed unlocked). This is a discouraged pattern even if here it doesn't
> cause functional problems.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
Thanks for the patch
Acked-by: Alim Akhtar <alim.akhtar@samsung.com>

Tested this patch for basic UFS functionality, UFS still works. 
Feel free to add
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>




