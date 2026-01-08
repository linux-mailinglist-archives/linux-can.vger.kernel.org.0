Return-Path: <linux-can+bounces-6041-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D08D0383D
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08FB3301A633
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE444C5F5A;
	Thu,  8 Jan 2026 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJ+sVKVU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TZLWhW7/"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714447C667
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881001; cv=none; b=M/M737pXNwTqRPCHwxQFA+BidQyZZSyboYolWx4x6WuZHLiO5QT7r8grtFHiWrOuxRXycliTE/am+VE1xfS0xDdCrnfjnG0hB2u/hBRxMgdSzyD1VnVXB2mZ43tuX5lmCa4rDJCFTcupuBKVwUUaI0DjJBImBKTnWs062JUO4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881001; c=relaxed/simple;
	bh=O39RT4mKZRaavt/btcDjvj1hMxrekOAFfr/h4cMIwOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCUG2z1C4I5GMrb6mj7LDo+oW1faTcjfAJUj+/Dtu8nttI4yW7JzIkcW+TxLCtVpqgcM3Ubc69F+WTThI+H5OyafsR/W5HPp4vyAVdI7xZt//Rneb70zF8SNoARZVZJ/9YeM4ylkbvk61AniK17ckCXuScwMyMa7hMFLrFDHhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJ+sVKVU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TZLWhW7/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608AhvgO3701052
	for <linux-can@vger.kernel.org>; Thu, 8 Jan 2026 14:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/rikJvWWJcqzvlAQE9QpGvX0S3pzPLa+z+Q2zk4Dv4w=; b=gJ+sVKVUwlk6O/GS
	GysaPtQM6AwluJeSO20A4Qg6+IxWEInxm+0MYFmOIH2/pK21B0yRov2s+9hYVKF3
	tHRJl+Bmv8h0OxMh6aqqwT6IRomDfEWzd/Snpttjh0ON22rFloiXruwiHuZb0zVc
	1n6gcEXQZ7k5Vqw7xNJVYphi7uyvl6SLT3WYGVkn+Xgtaruc2dyvDTEjUGi3dWQk
	U6H9Ov2piSCt97TOPINJKjT/Z26SaRvPoWKQ3Bmnoam78p0I5U4QvsvxEO6bbzyy
	SWUC/iV/hHGFHzB0fqkN25Zyd9IIh0SDZxUwQ+FtQeDNqY8EI0xd/CJdKprELTVh
	iS8UBw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjb39rhsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 14:03:19 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-656b7cf5c66so6046803eaf.2
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767880998; x=1768485798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/rikJvWWJcqzvlAQE9QpGvX0S3pzPLa+z+Q2zk4Dv4w=;
        b=TZLWhW7/pIU7MjTGqL3aZn6oGkdM0/nXpM2rZgbH4RDJxM+BPZe7XcX5K2Rk5pHRki
         VpflJkcCal0pkoVM05VF9UKdWmcUuBSTAlgjMSzu7ZuV7d75sjBv3heM9uaBnQUHFP/m
         7hft6rH5ZuPgePJ04aAgSq+sEESqe6+XW8OBGPJ4wrGYKSZd+cu9ise9RQm4m1PmfGh2
         S28yIsX2Ahg0LFRfSlnydGGgZdHXdicKYmhIPvm+DiCWBSWYb7eDxLsPoCQasq+eV67Z
         IEUEfPiqBrAtBL8k/2IXGqM2TJtldqtfEv7xsUV2yXO1Ynh5020i8fmzDGtAhaxP7HkK
         ihzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767880998; x=1768485798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rikJvWWJcqzvlAQE9QpGvX0S3pzPLa+z+Q2zk4Dv4w=;
        b=cDTfMbaP62+GkzKzVj6yvDXmQWntk7a/FgV4Xy76RI7OB2BlGJ5V8K7LNMFlw4ckkk
         +wdwSQLxj1QOI1I4YwYEKjS6G94ACocYs4X6f3RdOjfK/wS/AdkXtyMwXGBBjg5hsrV9
         +z2ZwGPjBFQ1nYytG7BtFkJNOhRFweYFJWYDQXkp7S9FTa5wVsV8p1NBBC+QtEilW0S5
         SIViRA9Pt9DsU7sVSrSH7nvs7Dhgxs9/V9qBjIxoBV6kooJBGhoYHsMc/okfwf9Jd4iD
         rl/O32JF3S2nBVGEyY9sl30/UdxI2CQmdvC+qGarG3CPEhQrHNulS+uDKPUXHZXey6uK
         Irnw==
X-Forwarded-Encrypted: i=1; AJvYcCU5O8gdZ+pY1oqhfufW1CbRAdOfYddVxV4iM2DD9ozjUzQss7pP6LIGhEeDEItEtajzVmLYnA3gHL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIhFIlq1/ZsF8J6v8TUJ1O31iKxqCW1Zn7a+MssCfpp45ykWm
	cqTuaY8r9qaQrW/agO+LUt/5Wm4kt+v8uxvCF+iM79q2uPHbegOqJM5Zaa1SktOSx8Sri1oAyf2
	KWS0yBTb/6B4PCXNvkR2l5M/Tzb5trZ6gjVI7mB9j35ZBJVvsTCknDDYkQ5nIDxw=
X-Gm-Gg: AY/fxX4sPjdrsvKVMxP17vwNTbQT/FYscD3atH4OjuznY8tJf6ClW1sAkk/OjqdlNbR
	/KMVZZJ5VH2akrJk9+G7LNTp6c4I8SgVLp39io9BJiEwQ8Y3NAcsPAQo+hk0lNOUv3Cbhb+dVfa
	olShVobnITTXXOC0oS7wotL5K6mRAAgZ2OTuQLC7OcdiRNSEZ1yLK8+maIh6oy//w1g5nHZh6xQ
	nEJmzMglCfkVi99B1pKcsjR44CBjEcVNzYvZK5WRRvHfeiETSmRtWMg6S0EItxFDuVxVFRUrD/e
	ntc10bFejOmqCr12/grWnngrRs0bDGFWID+YZUfhVWg8+JejulAgHgM6ne0JrVKQNnVyIIsxJgV
	mfMeZE7djkm7xSmcfV22ew1kI1st41VYF8EkqETKA8WinNfKxJeyRAoHyPznoL62tF09QbYW+IX
	oqiOHISA/4pRuTO/LOJPhONLU=
X-Received: by 2002:a05:6820:618c:b0:65d:829:bad3 with SMTP id 006d021491bc7-65f550a39a8mr1747781eaf.60.1767880997418;
        Thu, 08 Jan 2026 06:03:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfyQcszuRRVSI6qdE95keUSR8R2mGsIFOnBdHxqgA3t+DEGEa/dLp6DleIwZNy5fV0t5UNMA==
X-Received: by 2002:a05:6820:618c:b0:65d:829:bad3 with SMTP id 006d021491bc7-65f550a39a8mr1747718eaf.60.1767880995427;
        Thu, 08 Jan 2026 06:03:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b717e7f34sm1150193e87.61.2026.01.08.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:03:13 -0800 (PST)
Date: Thu, 8 Jan 2026 16:03:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
Message-ID: <n6affntgff5wy4xmm255v5h2ejpepicpz2cybcuvsxmry5td6u@jucskv7zrzvv>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
X-Proofpoint-GUID: lnwjCCq44sXP685mxn9ZZTAyUBlUNEaU
X-Authority-Analysis: v=2.4 cv=X7Jf6WTe c=1 sm=1 tr=0 ts=695fb927 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=U-AYQkQNoRZMNvosi9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDEwMCBTYWx0ZWRfX8Ho6R80LtxMx
 rLDpXfEWday1YCbQyx17ByQV3KzxI3fIriQrYQsTGcMJSMdlwXIk/7C6/6cL6vximG8I4w6Kpq+
 QSw5M+UrIPEHqvz3q+WGWgq+ilMaWegvbJbK3ZkzDhX9b67BSGjv3Qsnp3eQSEJ2KCfcxvKU5ob
 c5Nbb9KlOhWH1C4SncdkESdbP1Sw4U9kXE+gQEZiZLsArlSwUa+Y8KA4dvqfQA2Gno/o6XmV3hI
 345FQ/E9ijXEo+8msyKIjHclAq9Z8UR+T71eW6v3GTFWoAnuKA3N03jqQ7WPB/vf++UraTOVAyP
 lDfvfW5dsjpPuDMyqxF95P20Z9nIOy7p1jKzbIQW5aZbTYvmWwCwZObepZE1nGRYJBPvIw7AS63
 iOa+a2q0ImVp94jLTRzXc34gd0greodNGBmZx807dUqEXCuZ5nn1F3sl40UP7l2kfmrNSAy9MAy
 f9zRSwwRUvRWpH5n2pg==
X-Proofpoint-ORIG-GUID: lnwjCCq44sXP685mxn9ZZTAyUBlUNEaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080100

On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
> The controller is connected via SPI3 and uses a 40 MHz oscillator.
> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
> Normal mode during boot.

The main question is: what is so different between RB3 Gen2 and previous
RB boards which also incorporated this CAN controller? Are there any
board differences or is it that nobody tested the CAN beforehand?

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

-- 
With best wishes
Dmitry

