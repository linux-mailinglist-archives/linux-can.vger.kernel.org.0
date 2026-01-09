Return-Path: <linux-can+bounces-6082-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D32AD0A8F9
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 15:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E3930E00FF
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D197327BFC;
	Fri,  9 Jan 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGGxh8Ly";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COScgCA6"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB335CB60
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967558; cv=none; b=EDgO+iuqBJ57xAKpb+Pc/gG+ri3PMb98Yf3LAPTi992BmyXcnAkW1n2n5eIzyKwB4UuScQmZZAA0xgD4HuAb2GO7CpMh8uAihgXUFhowFT6jBe8cNSecikZAPZW/85r1MEOqraBZgXJRBJXFZ5FAf8uFU3u3nQSga1kFZRSCDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967558; c=relaxed/simple;
	bh=2AdBV5i1WwNduZ2bTrHnKmOSJF2fPopX7FU2b6C7YPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPhPrrMezZSpKibwXZ5fLO0sMvuhCxH6IX+RJWTFfnt03GCaDP0ndpCUh5jdt1QPdQRoN2yOtdJIU/Wf+iBxMXUYXO3mrBIB2Ml/W9Nvvr1vuTGTCHKh35mDO+Jjsj1dIAMhHOo8QeYYRMT33lcUBzibqdRibXxpANgWSlvPErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGGxh8Ly; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=COScgCA6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609B2oT11062645
	for <linux-can@vger.kernel.org>; Fri, 9 Jan 2026 14:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqpcBxfdo/a/4zRNniytxNfHyMEnxMTbjhhO+KZCV3M=; b=IGGxh8LytC9HFxJ3
	e7tmt+WV4v3QagMZyy8E8x5QmfklMOj8J0wEPLVoOs/SlpklNHtemrmTBcnrHB6a
	yRQnV7DwDZw82AcnKGdsILpKf9tRwr2fieuizjIi16jMUMXb33JXHPNXF5ojkJ/9
	RyPWZ5//ynnr4kbGIpDl+7mbGOMxZ1doCjZqZAsUNhQrVNo23rcckcHxilOuMw/2
	rTGvwtj0oE/LGFuWQc6vKmpwpchcgJcKYyq0TT4QlVTWZLdbyFE87HLXcftWtFlU
	E3D4EnovyUS1ltrLXeL9qXnpobYx5y3EzHR4+VVoZs6lywojRnB5rZDbNIBB+kie
	jWbz+g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bk0f68f48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 14:05:55 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5634f5bd39bso4368607e0c.1
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 06:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767967555; x=1768572355; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqpcBxfdo/a/4zRNniytxNfHyMEnxMTbjhhO+KZCV3M=;
        b=COScgCA6cTLm36NAsEX41idm8vAx8zJ0wpWI5+bG8jfVmnA7q0mH8i8tMOJQa+NhvN
         mJxHGPlWChI0eJ90eqBuK8/AJ0YlJsls1mHt3mYRKwX4V04lgt+3l20hEG4Lu1rC62q3
         YG7OQRga67ZZQa7o1HPhqyzWcnR5zJ33gOO3PQ1fC67dsSijLvJADVdzzOc33HAVL8uD
         9qXqsSSOmP9W3Nuofi4a09WU4hiPbNpmXCPxttCEfoqyWWg0+Djr4NKipT8Zev/cxbDP
         VUG1prxP19tgR7yYNBadUHdDBzScHwAI1nppBdpJ+owC6tiioNlOh5jH6qo2VVMNUjj6
         ixbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767967555; x=1768572355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqpcBxfdo/a/4zRNniytxNfHyMEnxMTbjhhO+KZCV3M=;
        b=Q8hm7zJEdPTiCodD2PZ9uilrbuVAgFcxoFGHkg66xh4CbnOb/r6cHijKC4DvnghQty
         UBpY3W6oKRVS3ljmt3l0uGWAIJ8A2CC+LLy7avyf0AsGBqJhbXL6c0yriIeA8VVQ2x10
         CkRP8FcN32mtr+UeHvj06V0JR97RkAS30l/FkbYTT/8TWEdU//Vf4Rr0scKtSVNVMWIw
         rAII0DZUxX/kPRTWeDUi+Dg/OocIjnZ5pW8jBwKU2YCgoJI5gMkG5V9NGbYBy0BuWbrb
         J/LPeivlLp+fZDBv16/UNeU6mki8W8VsSEau8cUgDt+jsBrakkxKwpqs7Z1rW+t5+y90
         JM1g==
X-Forwarded-Encrypted: i=1; AJvYcCXC3dr+ipEQIMUDReOZ1B3n1qNQfpt+iNzdI5hFRRE6SEIcDKasQb/8trzYm/qcljR8zMUQitTDlYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw596cRbd9+5lSeguTUv/7fLjlyGMZgCXjWIQxJABug7/7LhAAT
	4mDplM5/oy++7yWHbJh20+908w3QlZ6QocbIHGIMYCffNFGDUOtgHjaieQXxPWehG8Edxnfr9W9
	ICR2LwBfr0efuxJQ5MJ9NooyYShWyOouzKtcMjiAlD4H7iaBs12PftBZbREskT9Ff16o7HQQ=
X-Gm-Gg: AY/fxX5io6aZxhityPG5zsYzeHsB2YJSj+6MkmyJO7Sxx7HsdXQu35GBmcPxrwlezpS
	4JrDrmsvhIS0Sc02tIRdIZ/pTqW4XhpD8bddFsgUnjmcHKr2ifrgEQbDOjk3o0t8J89AObVb2Ei
	pcbhsxwZYsBXNcXkaVDUgwNHsJJpI2S3im239gbQeRpNXRhcv8iKDBodWQCwPmU3thv3ZGj9h7l
	0QZlyuxtbQQw+EPn1nhuFwLaW0e4I57FcUAMUWgSxT58g5bnEuYpbm8jFuZbk0Q9RCRlLE6FvI9
	QuWtbXE8c+MBm3Td4oFqfgS/aglkMY9wkIvESpAW8TNIBzgUnbDMIZ0oUUtJy3HPOjKbXjiHhZ7
	oAPyk0vIzoeAjnkrG1CLRvUv+/2kvC3cr5zCxrB5xTfAKojsGyZLqV9/tlwl57xEtf4gz+RybKX
	JDqZh5UiaKgS1GgKpBb1Zisy4=
X-Received: by 2002:a05:6122:8710:b0:563:618f:b7da with SMTP id 71dfb90a1353d-563618fbd24mr1693562e0c.19.1767967553480;
        Fri, 09 Jan 2026 06:05:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVBGqgIZRVN4OaS4/wzZQzVT1RQHmlxD8j6Yg/Jt6Pl6TAeEpTA3dG8UlIPHbNVIw7wyeUDQ==
X-Received: by 2002:a05:6122:8710:b0:563:618f:b7da with SMTP id 71dfb90a1353d-563618fbd24mr1693514e0c.19.1767967553041;
        Fri, 09 Jan 2026 06:05:53 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6addaab0sm2472730e87.28.2026.01.09.06.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:05:52 -0800 (PST)
Date: Fri, 9 Jan 2026 16:05:50 +0200
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
Message-ID: <wbx2qrkhpsntggzqkzkpi4sa6qv3buhkjbwmjoa7zgw2oc4b7u@qugyhcxb6qrh>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
 <n6affntgff5wy4xmm255v5h2ejpepicpz2cybcuvsxmry5td6u@jucskv7zrzvv>
 <5cdfe5a5-3c78-45a2-886c-768b224ad776@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cdfe5a5-3c78-45a2-886c-768b224ad776@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=P803RyAu c=1 sm=1 tr=0 ts=69610b43 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ha8eQrMcodomtfQpJIIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwNSBTYWx0ZWRfX6jBChxI5hySm
 SF42+NBZjgtfuHkrghrX8vqVZHAPzmDG6t69tHNrJCdv9JbOm8y59ux5LjuRmFNpZmrWia9uo2e
 4J01PlUGnX/85ormStQXn3ZKLCrjQqx8nTblysXtgR8x6Wvv6ZhmFW3X7tLxMde50PYli7u+JQJ
 MO2xIAmgELwbtaB4ZRAgZzYuDRXg6eMB0hHst+BlDY0fsx4cXkFeHaQ9fYCtI87nOWSNYC9fyeO
 6VBDydgJg6BQARtxnEJF4Sh5plHOaNXQ1qzMr0XwdKgIZ2HfxqcnSTdlHFc7XzyC4lxYgABS7EM
 et+W+d2wb1FZVZztmf25ruQBdwdnYO3lN6Joez0I0aF4Eih4JTUL52XXmk0s1Ax+oUcPKMGD2rH
 REFPRcjtTA981WeQQJX6meV+fK/SykQK5BGUvHoBceJNXqvxFpZ3T8MIOc9HJFhCHJmrTITdKcS
 zTWOvK00HpFsDOo1g8Q==
X-Proofpoint-GUID: fep3CyW59TAiLiq4L1wfvWcStsKpvOc-
X-Proofpoint-ORIG-GUID: fep3CyW59TAiLiq4L1wfvWcStsKpvOc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090105

On Fri, Jan 09, 2026 at 06:23:39PM +0530, Viken Dadhaniya wrote:
> 
> 
> On 1/8/2026 7:33 PM, Dmitry Baryshkov wrote:
> > On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
> >> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
> >> The controller is connected via SPI3 and uses a 40 MHz oscillator.
> >> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
> >> Normal mode during boot.
> > 
> > The main question is: what is so different between RB3 Gen2 and previous
> > RB boards which also incorporated this CAN controller? Are there any
> > board differences or is it that nobody tested the CAN beforehand?
> > 
> 
> The behavior is consistent across platforms, but I do not have details on
> how other platforms were tested.
> 
> On the RB3Gen2 board, communication with the PCAN interface requires the
> CAN transceiver to be in normal mode. Since the GPIO-controller support
> was recently integrated into the driver, I configured the transceiver using a
> GPIO hog property. Without this configuration, the transceiver is not set
> to normal mode, and CAN communication does not work.

How do we verify the mode on a running system? I have the boards, but I
don't have anything connected to them over the CAN bus.

BTW: can you recommend any simple setup to actually test the CAN bus on
those devices?

-- 
With best wishes
Dmitry

