Return-Path: <linux-can+bounces-6222-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 786CCD39D84
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 05:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CFF30062EA
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 04:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F7242D9D;
	Mon, 19 Jan 2026 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WEH8pBmE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z1ni0C7x"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909C171CD
	for <linux-can@vger.kernel.org>; Mon, 19 Jan 2026 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768798308; cv=none; b=LQ6rXZ3+A0oCTT0ZxIbb1exPbHZjCrq/5Jye9hHXh67RKnQUp9fBVKkqszjxd6F+wLDpn5GnraTrTyKT/07WYOra3iYOlk3lLE3P/0GofITKIHfiqWAgXUxi3ONMRmoxuFvFsu3bt/zbsBNYKbP1JqFaO+x7e+HDCiWbQ03kCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768798308; c=relaxed/simple;
	bh=D9Vaj7OQrZmk2pDElqiYd3JWff9QOz69KFSU7Ygjlp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcYZi6CYYUrGyQlDH1ozcBOu6GmzCpItFOj60i5MnhUBDm1uVdYfQepGOU8Jr4h+tvB0rqPbib2ePXBKrxcAIoCmwxLYrd5dIKz/seDR8T2xfnPA729c0iKRL3oxLKjc6EoDVP1itJmKeWG4Uy86fi+AhkCkGcR7pMoj7pExJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WEH8pBmE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z1ni0C7x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IIhe4M123243
	for <linux-can@vger.kernel.org>; Mon, 19 Jan 2026 04:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pe0ppVmVWykTbR56gl2RExAsGWnQBkCtnrcpym1xn84=; b=WEH8pBmELQ0w82pd
	mqDBlC45btg3vdqzZ064cdjHJfZxXD7nRGzb0luu3rYmU/GcIGqJQDBrmbOtvdA4
	LbmNfaFQWzIDVYIU19XpJuDEGYOa+/XzMWfOQRo80llf4tEXLKcm3wrmuk50jVQb
	CS/nve8+NwpPSs+aJZiaSTtGzIRRmTJM/zZW9RAyxx/pHj9k3dKj5b+wwVC8R76P
	LIxJsn39Owokbft+hoXUe/cgYaZT3mkdp2ojS2XDmjr40e7i14UfSvkXWDMd7li6
	1WEq1vx9y7qmtsw/jzLEdM+Jy38Kt1abemT2W61790Fp6tJwDaM4vQcGaM12XBMG
	VDQPtQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br1e5kut5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 19 Jan 2026 04:51:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34abec8855aso3870654a91.0
        for <linux-can@vger.kernel.org>; Sun, 18 Jan 2026 20:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768798305; x=1769403105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pe0ppVmVWykTbR56gl2RExAsGWnQBkCtnrcpym1xn84=;
        b=Z1ni0C7xYmHQMXAeWahHRTnLXRl3EZxOlI5JKwezxspeMNIJFUVT+lw3yzqZmqFX3r
         rg+SMCpcrWMqDmYSPmVeIYa+SEJkh0aMr/z90CwXB1fR01LtkP4LKxbFmJmIjX5s+sov
         AHjlAdvKnkjsJ3j00kmz0hX47G2jXNsm3CPg4ln235e7rlJCFQOjuPS5SaQTb85Ryn4X
         Mvbjb7Vov1tWj0BB31wGfdVLf4FfQrmzsxp+DAPxegftNp9ojygjTD6jA7sK8FNSEtcK
         Gwc6aHgYocoPKD+U6MA+PuqvlC5AiRj1fq3D6ONu9kx5Tj4g/WBeU/d1KCFkqoQPwkGt
         3HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768798305; x=1769403105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pe0ppVmVWykTbR56gl2RExAsGWnQBkCtnrcpym1xn84=;
        b=Ydhl3LVVT0fK/C0X8KXypblDQqVkwKVvk5D+Vo+RAugqff7g8m82RmX5PBGUPotLVv
         SI87Ou4TeIVz9D9/77ba3yfZCcREMWuIsUY0J8LuGbfapV7JpuNiOourb4GvJPyiAV+F
         A6iFYSVAGhmDCQl73Xc3PZiUym5QRJfiqriNFEaa/z40ysvreWghE/ai6Xmow1uDQhqH
         26IJx19Ry/kZeXJ1GBKdLb/QIr/2BzT4eef6JYqrNcxVXVkhewJLkdmLeGH5pcvoKlgD
         +oAWhVcb4TVbd/ajpECUIi6KTFCl5EYHIfBJRm0R1e+fC04NRASJdY72TVZmdEnqzuqv
         kDnw==
X-Forwarded-Encrypted: i=1; AJvYcCWSyrwzwMvZDtWaohAFOG5srxzwhxG2iobP0Fg0EJjaU+T4fXA0BcvIR+Ov3LIh6AIztnzPfoM6bmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrO9xjgmRZx6C8ksaaElqXiHG+X9alj/FCrQ6XHqxC7QtAYmN
	A7OzACwvv6DJGNZ+2dUun54wPvo4Px/6FV5ZbjLtNM8mFzMkwWDbEl0Ero87nGCTkRV1aUY2IOW
	oxGZlEbrYnLy21gTbf1I+E0gBB+LwslGX8BcilMwJIsG5V6AHChRLDsWrzfvXelE=
X-Gm-Gg: AY/fxX5/OyH1W3cnYgJx0mqnHVn5Bp3ZIAeEFtieMWm9gCI83CvGYVwfEw0BqANpM2U
	5EreHRpjcKj2PvzdbTo3CMyWmb+5q0SEYIU2HAVlKAVL4ASoxL1tK16gQRJ0n7st109C1yx73JG
	OPikkRx12QxA6xNqAunQ/9NBsBPNkqUJIGCx1XiI+srwh8ZRpdz8quugPUhcpDSR1a1aLujNobU
	YVAbzABIprTFBDCV85RXJMEcoYXGkCrYwAVmUlDPQVbtVntHy6sK94J6YWyRvcAVRxA0kV+lGWL
	4hTqoykjRQrQwB8B5dgzCQeIz6Jm6u9qyI+UEbWqjvI3/9FqhtWiX3ygsMxY0HjLKdVf7g/WegZ
	Ydiu6bTzj221E9X1FIwj6LK5lAXGLNPcitdAkTeecxA==
X-Received: by 2002:a17:90b:58cf:b0:349:162d:ae1e with SMTP id 98e67ed59e1d1-3527327df4fmr8987887a91.33.1768798304546;
        Sun, 18 Jan 2026 20:51:44 -0800 (PST)
X-Received: by 2002:a17:90b:58cf:b0:349:162d:ae1e with SMTP id 98e67ed59e1d1-3527327df4fmr8987850a91.33.1768798304047;
        Sun, 18 Jan 2026 20:51:44 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527305490fsm7835596a91.1.2026.01.18.20.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 20:51:43 -0800 (PST)
Message-ID: <316fa702-6cd8-4842-aecf-c176a5a53e2e@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 10:21:37 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
 <n6affntgff5wy4xmm255v5h2ejpepicpz2cybcuvsxmry5td6u@jucskv7zrzvv>
 <5cdfe5a5-3c78-45a2-886c-768b224ad776@oss.qualcomm.com>
 <wbx2qrkhpsntggzqkzkpi4sa6qv3buhkjbwmjoa7zgw2oc4b7u@qugyhcxb6qrh>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <wbx2qrkhpsntggzqkzkpi4sa6qv3buhkjbwmjoa7zgw2oc4b7u@qugyhcxb6qrh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDAzNyBTYWx0ZWRfX25xwNX/+4xTp
 PXYbSCqMvsK/A6EUuxGnwcAKsslsXWjlch0SL92xJBBHiGIPWjLKy65DsTP0GeeamqDj5lMPS7Y
 Xz/SjBiilQWDecmKqPxdar7lNTYKNNgqhuKeWOLcb8QU5jv4bFLggiRZh9XXfpjs7bg6+n+Daze
 QV3kQjtN9GlQessToClX3BngBaIGx4Tmeo81I4LxeD0lEWAqmmCsym1jzaIVtnhQE1YL07ANMJB
 6H3cCKENay4Oo9ffODeGyt2XKBf5dhw3Xw+HeIachx0UXs5mX2jzDIhHjF7arIBJiP9gCFAtqdK
 BBmCCOl+M8YzT8MMHoW6508wti2n2dfkgROPROK7/h9aeAU7ddBaElXPZpvjVT1lqUWjZ6lM2RR
 9WvP3vdDxeBreYpzmyTstYRRRkOQnaErx8Nf9/SUBYtBqV8BvvrLCDEpEl1F1oo7CAGn4OUL0em
 mBxEtqQUxlN831XnurQ==
X-Proofpoint-GUID: T6Z6dfAaQ2gojboTjLMCYkB-Qd5NG4qu
X-Authority-Analysis: v=2.4 cv=U5yfzOru c=1 sm=1 tr=0 ts=696db861 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=4ibTxloRqUhnMlsHXSUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: T6Z6dfAaQ2gojboTjLMCYkB-Qd5NG4qu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190037



On 1/9/2026 7:35 PM, Dmitry Baryshkov wrote:
> On Fri, Jan 09, 2026 at 06:23:39PM +0530, Viken Dadhaniya wrote:
>>
>>
>> On 1/8/2026 7:33 PM, Dmitry Baryshkov wrote:
>>> On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
>>>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
>>>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
>>>> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
>>>> Normal mode during boot.
>>>
>>> The main question is: what is so different between RB3 Gen2 and previous
>>> RB boards which also incorporated this CAN controller? Are there any
>>> board differences or is it that nobody tested the CAN beforehand?
>>>
>>
>> The behavior is consistent across platforms, but I do not have details on
>> how other platforms were tested.
>>
>> On the RB3Gen2 board, communication with the PCAN interface requires the
>> CAN transceiver to be in normal mode. Since the GPIO-controller support
>> was recently integrated into the driver, I configured the transceiver using a
>> GPIO hog property. Without this configuration, the transceiver is not set
>> to normal mode, and CAN communication does not work.
> 
> How do we verify the mode on a running system? I have the boards, but I
> don't have anything connected to them over the CAN bus.
> 
> BTW: can you recommend any simple setup to actually test the CAN bus on
> those devices?
> 

I tested the CAN controller using the following commands:

1. Loopback Mode Testing (GPIO hog not required)

ip link set can0 down
ip link set can0 type can bitrate 500000 loopback on
ip link set can0 up
cansend can0 12345678#1122334455667788_B
candump can0

2. Testing with External CAN FD Adapter (PCAN-USB FD)
A GPIO hog was required to configure the transceiver in normal mode.

1. Probed and verified CAN transceiver pins and connected them to the
   PCAN-USB FD hardware.
2. Configured the CAN interface:
	
	ip link set can0 down
	ip link set can0 type can bitrate 500000
	ip link set can0 up

3. Configured the PCAN-USB FD software for 500 kbps arbitration bitrate.

4.Sent a CAN FD frame from Linux
	cansend can0 12345678#1122334455667788_B
	
5. Verified reception in the PCAN software.

6. Transmitted frames from the PCAN software and validated them on Linux
	candump can0


