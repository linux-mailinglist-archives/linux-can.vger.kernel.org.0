Return-Path: <linux-can+bounces-6917-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IeMGKXGqGlaxAAAu9opvQ
	(envelope-from <linux-can+bounces-6917-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 00:56:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4F209386
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 00:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D7B30D544D
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61A39768E;
	Wed,  4 Mar 2026 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDzVpAV3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNvDKJTH"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45938836F
	for <linux-can@vger.kernel.org>; Wed,  4 Mar 2026 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668483; cv=none; b=hyquS1dQMTuoa9TlB/ZkdOUP5VDwbjcfUP7rhknXJO4qOPzMT1oEUHuqeXf0KXXNKrkxFFWe/YRmmhZYz722D8Vh+Z9ayu7kaIbHJj96cuwjigkYdzRYosJ1bZKuJlvUBzL4/H9uxhAA125/9z6ca+Bc5tDE0J3oQstcYKseOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668483; c=relaxed/simple;
	bh=EHwy5JNR4+Zu1tdmuN78UyKkfOq13HkK43t7lUXN9Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaOMc7/KNLb0jxVP3y5U/9XyU1vkrxeYOQQho0jNk3i5b88GeNfv1ZvKXjskn6jOXLLG483DMCQlXk/EAS5IT5t9iQ2IRoeRZeADh+TwL+l1l/jCJDO5EkL2lNeRFPvvn2LtIipI8KKr3XcmxEVMlwMcGp6ojtIHKTxszNwlZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDzVpAV3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNvDKJTH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624M6ogq2275079
	for <linux-can@vger.kernel.org>; Wed, 4 Mar 2026 23:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=D9sak1pWhxVBrwdJ2BGlDRM1
	u4FQCLLwnOBWXp3tU8M=; b=YDzVpAV36G9FJiGclgosp/BCt62vM9M9b056E3f0
	U+5xxlejiEUamIMH96BixcO5AaY77ZWBlSAKvu5XqmjeqoAku40urrsPuKmmnS9v
	3OkMLayFRlSKj3dBR7WZsu0j9iU2lRzpg2d7kLVS9w5ZRVAO2FJ6BsTzjCt69c98
	JFzB7UN71X/+3QF9qLWJGMzkqHwQXXEY1ttgq+wcei0KjxR3Fsb0D++XmNf1CbY5
	5aKHM5x6QqkmdYtjls//+oqXfFNFmC5IchUi4ZbV2wIf7afsnXeYSOnIz5G6c9dJ
	RXin04p5y380S3mSuZNgncUGt9sD1j/T6Lf+R7oqd/C+mg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpc4muqbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 04 Mar 2026 23:54:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89a0013d87bso79455946d6.2
        for <linux-can@vger.kernel.org>; Wed, 04 Mar 2026 15:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772668480; x=1773273280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9sak1pWhxVBrwdJ2BGlDRM1u4FQCLLwnOBWXp3tU8M=;
        b=WNvDKJTHZVa8Mp4K+8jW++DoQh14uzwuQlv5PUa0f7Qt86EJ0u84PflnnNH8oGtKGh
         CXPz/YYX8iN/nrjQiKR0Y5bCySvGeb8CD0pdWbRckB8rhjQu32AbdhnlSYx8LYfmn/ip
         +ByAldFvFHz0KBkb/wGYP/DBk84lW9I0qOvfQvTseAlkjZSLmaFHEJ9TQjRjNa19zFys
         WHOv9nKepKkNCEhkPNxRCaR7c5f+J7pNpZGZdWp5dmW+ArD//1NzgLPq3wss2nE6L2+c
         OBTGOIK4b5HHN5l+EV6RL4fgwEzazA1f4SGEcNTLWAj7P+G90VGRzfZRllBituq8aa8v
         VF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668480; x=1773273280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9sak1pWhxVBrwdJ2BGlDRM1u4FQCLLwnOBWXp3tU8M=;
        b=eJVNpa/rOym89uUhme0Q06ibW7KwjwQRk1lhYRIQqR9RSc8yL0j+I6/5uWwDFqkQMJ
         SUGgxIUD8YG58hOyS817ghY/kueXsX2cY6ukTapYIlHnzEsQVL8bpHWSmaC3ygso/A9l
         2gzKDyw0olnZrh34aI1Rri2kZz9KZOL5hCwbmi6uufL0Xo7p7KXnGv95e9Fko4N6ReJh
         +JIhAbTH+lFTUOhoHdIPPnSatmELIqm72H0mqpvFcTha3oXj427G/fQScz6P1VhXTNRP
         vgHOIu6jF2sGIHjNUk7xwMzVqwlOGCGiE7LPSCwuN7Eb1pVy9QaLzly3uh2Vyqewwe8f
         BM+A==
X-Forwarded-Encrypted: i=1; AJvYcCWcY6fQJHUTsdBr7/YUJ4fN1uY7lG4b6vh4CqYk/OKI9c102xEKBgcb5Fui6q1+IlpeycLBVo7nB8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseeraF+xMkpiAauwLABGZez2bJOiGF3lRdu+l9er8xThD6GMn
	cDY8F5I0bjDG73NAhCQu1v9CcH92aaVBSwEhyXliJ/PYvxr0LZCFoiQ0fXdMT/58VCtPGtPUY5s
	j5avMB9XyQbxZNgel73MwC/piUX7JJuciw0D7AQBCwPwWzzzMCg4xuaIi2q4ht8U=
X-Gm-Gg: ATEYQzwjuWfQlxg8WNdKivYKPQI0VAJs7SR2yoOiyIHEIdziF4Cz+NJOR4nvTTrw264
	095XcPYnvw2AynsVnAhb+emg/t+DK10L25vtyPlgnSlFcpqogd9avmYFqeuLxyf4LxCuxUI83Vw
	kIe8FRPQAPfzjCIEQ6m9MMaGAmijpQ0/UeKJlZuoexLsfevNXkYa0H9FuvQtp5/dYCSlcUuXuUR
	4x3bidtMg2XmlvIXOdaxMOa8fGPBZf0LujmZ+mYcL7HQV1gDJeoQ7aOelICcjuELJ5B/v/dPI0P
	LtOhIUeRk1X9STd0qeKH8m/bW5UYIo4oBZugKmRL22a06mUna0KDAZ5bQ06rU5ZfEcq2NBFsLPb
	qlWqE4ddHF7AlVcg0VJ6NlnSXwAHvZQthkP+2dglHJztt1m+EtWWa+eEUNQzGHUt8i8U+et89Nt
	mduKV2Oze5vOyzWKg5/ZyPAgYk7/w8Mr4fhnE=
X-Received: by 2002:a05:620a:2986:b0:8cb:5442:d537 with SMTP id af79cd13be357-8cd5aed61e0mr519314985a.12.1772668480067;
        Wed, 04 Mar 2026 15:54:40 -0800 (PST)
X-Received: by 2002:a05:620a:2986:b0:8cb:5442:d537 with SMTP id af79cd13be357-8cd5aed61e0mr519310585a.12.1772668479418;
        Wed, 04 Mar 2026 15:54:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123573c42sm1615588e87.72.2026.03.04.15.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:54:38 -0800 (PST)
Date: Thu, 5 Mar 2026 01:54:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 12/22] phy: move provider API out of public
 <linux/phy/phy.h>
Message-ID: <cleew6tvum3jnflztfcqfwtafu4hjizjvebzr7qrsbnnp7vvrx@fjqhyh57o5hw>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-13-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304175735.2660419-13-vladimir.oltean@nxp.com>
X-Proofpoint-ORIG-GUID: tAcSVbNm9BwLTiUwRhapysFlK0PbcPC8
X-Proofpoint-GUID: tAcSVbNm9BwLTiUwRhapysFlK0PbcPC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE5OCBTYWx0ZWRfXyRNthT+qoDpK
 wnFE8fs9gLSFjL36frABnyrp8rh1Dnqaj1JfSdbuYA80dFJc3oM4pd9QC3BF4X70U1WSmAP4/ix
 /YITFK0U6NFr+N5Y9tME8KAmoDF33hMCCF5uDZQUvuTsgZ+viF+YacQyLYzJsPMUrKP3YDzl3N0
 oFUiGWWmI/PmblkFFYk8fmr+9GXCmqHikUFNFwYJJWB1b2ZkVQ8psG6TqJGAtZNiwVrbN9Nq/Pt
 D6q1MKr3GNuwKD+znmk0cEykA21WqU6C2RCIhZyiS2octUQumbuJb3kJbaIGhCCw6AufGXLOeep
 ZmkP3rhB1eMxHtAkyL2GIGXuPv8D+OcvQMljvioNzgwmMJ+I9NDs5czB0ADrFx8FZ+f+n19hAht
 I5hHQjZN4XmBPRrKBxIoLJKUQRveNQagj7m1zILv9QumGxiesgCwbJEPHBr9pN7ebrzRsDAVHYe
 3YDpbmeTNmkNTAAOEjA==
X-Authority-Analysis: v=2.4 cv=C67kCAP+ c=1 sm=1 tr=0 ts=69a8c640 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=8AirrxEcAAAA:8
 a=EUspDBNiAAAA:8 a=lO4ColjPjyWKUZOT0LYA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040198
X-Rspamd-Queue-Id: 0DD4F209386
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6917-lists,linux-can=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:57:25PM +0200, Vladimir Oltean wrote:
> The major goal is to hide the contents of struct phy from consumer
> drivers.
> 
> The idea with "phy-props.h" is that both consumers and providers make
> use of some data types. So both headers include "phy-props.h".
> 
> Two slight points of contention.
> 
> 1. phy_set_bus_width(): Vinod explains that despite the current caller
>    situation (9 providers, 1 consumer), it is a consumer API function.
> 
>    The use case is that the controller (for example UFS) may have
>    limitations and should set the expected lanes to be used and width on
>    those lanes. A number of Generic PHYs can support multiple lanes and
>    multiple width so this is way for controller telling I am using this
>    configuration.
> 
> 2. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
>    We do have 3 PHY providers outside of drivers/phy/:
> 
>    drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
>    drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>    drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
> 
>    but the practice is not encouraged, and with time, these should be
>    moved to the subsystem. This is not something that I can do now.
> 
> For temporary compatibility, keep including the provider header. This
> will be removed when abuses are all gotten rid of.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/phy/phy-core.c        |  34 +++
>  drivers/phy/phy-provider.h    | 256 +++++++++++++++++
>  include/linux/phy/phy-props.h |  75 +++++
>  include/linux/phy/phy.h       | 499 +++++++---------------------------
>  4 files changed, 458 insertions(+), 406 deletions(-)
>  create mode 100644 drivers/phy/phy-provider.h
>  create mode 100644 include/linux/phy/phy-props.h
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

