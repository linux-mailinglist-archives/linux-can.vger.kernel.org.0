Return-Path: <linux-can+bounces-835-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B480D91205D
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD41F241AF
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13AE16DECF;
	Fri, 21 Jun 2024 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NYR9hKXM"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309B16D335;
	Fri, 21 Jun 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961691; cv=none; b=lYkaDpstdBQLzaYRm/ZBSvFs+NyecXhuNsS4q07IT9ejzYuKGyf8QQZdnTr+IdBQEBFP24jXhnRzgFux3yPTmftAhC88c8oHp0I2mFi1Ef2eTRuJM5tFHMi6rZfeD994Gm+mRbrEcBdnfitKxF8ZoYPZg28JeuGbQt8SGOD7Mdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961691; c=relaxed/simple;
	bh=eAk9gOkLBlRQrDeTJO0W4a3ezXJR6fbg07voMiFyTxA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTCJLaODPmcvwUM0/yI28wvkXkzZoOyCnF3ALaLRnRuAj0agkRCiRTAUEpf0jKlI4Nd+dWmmMNnLQS7chl9CMSr15CsGhZMH40ZUmMdXCTzCX9oEQ6priXVHRDsZHfPiRAM+biIDn6HPbSv2p41Ku65Cdom7avmzWhLXWVoauMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NYR9hKXM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L9L2oA007852;
	Fri, 21 Jun 2024 02:21:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	CCufIrz40hLEdPGerpnyd9wuw/kAjb7VvhJ+TqQiS0=; b=NYR9hKXM2T8ThdUR/
	ROIiEb2oCksJDjSpbtAtUlrdQFnDjagc7K6vjE6aPpiQzMMRIUvGTCcAAV6NBaoT
	m4n7yuMzt5EbtRaTIwaALmj92DIvkAGTEWcNhxTdMwD0pCwBmO7QSv/DO9QDhteD
	JhJgFGXtq/vtqQYsiuwpXS5PqhcIqf3FpbZhs1Bre+syoH1ZvBelaorD2l0amWhk
	Y557ylpk3a3D+wbgDOjsAoWMiCzZbKQLOVSxh6c53i8wLhZLc8cYiGZm+rdyhbdn
	cSvLGz2kvp2MqwLuqwVVHsRm5H+bo8PyzJzv8U4LjK11JXfNNmigLftJgb6ExI9l
	UGGjg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yw6t80004-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 02:21:00 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L9KxKK007805;
	Fri, 21 Jun 2024 02:20:59 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yw6t80002-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 02:20:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Jun 2024 02:19:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Jun 2024 02:19:13 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C45DD3F7069;
	Fri, 21 Jun 2024 02:19:09 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:49:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Markus
 Schneider-Pargmann <msp@baylibre.com>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] can: m_can: don't enable transceiver when probing
Message-ID: <20240621091908.juhoeb7zfo4zhsga@maili.marvell.com>
References: <20240607105210.155435-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607105210.155435-1-martin@geanix.com>
X-Proofpoint-GUID: oznMlDvDVOb7xXWCyBgbcGTQ5HWu4cFq
X-Proofpoint-ORIG-GUID: _v_-lH_1A7N3CBgrXvrJwaBVBoABDhJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_03,2024-06-20_04,2024-05-17_01

On 2024-06-07 at 16:22:08, Martin Hundebøll (martin@geanix.com) wrote:
>
> -		usleep_range(1, 5);
> +	/* Then clear the it again. */
> +	ret = m_can_cccr_update_bits(cdev, CCCR_NISO, 0);
> +	if (ret) {
> +		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
> +		return ret;
>  	}
>
> -	/* Clear NISO */
> -	cccr_reg &= ~(CCCR_NISO);
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	ret = m_can_config_disable(cdev);
> +	if (ret)
> +		return ret;
if ret != 0, then the function returns "true", right ?
as indicated by the below comment. But as i understand,
this is an error case and should return "false"
> -	/* return false if time out (-ETIMEDOUT), else return true */
> -	return !niso_timeout;
> +	return niso == 0;
>  }
>
>

