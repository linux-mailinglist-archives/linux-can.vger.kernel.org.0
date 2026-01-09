Return-Path: <linux-can+bounces-6076-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9521D0A5D3
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A226F307A03A
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C635B135;
	Fri,  9 Jan 2026 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkncIn2U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KlPISdsE"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CD33ADB5
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963357; cv=none; b=FUqnD1h05KZPL4GwNgL0YrX1QkrbBQlKxEyGNCZcz+q4Cn46jmHqe8S6yVAAZZWfll28gHAB28pozn+rn7qWUCvDgKZfzmNq4F31e6PDsNY1nV79iaHw79ihlawzXPmPZ65QdLJ3SmNmNjjdOJGA3k2I367jEgeGFHXohApdacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963357; c=relaxed/simple;
	bh=Ug4/iKld1hZF0G/aMDskAl/jEyBcg7VXYNJFY3DRVGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzmCElKwNnOoivQ1cVtoCTjZ5LJH1ZcEWTQvb7SsMeiKFiZP8ot/kFGNC1L1T1z0NA99r/f67wTElutju2ehWcQ7siIHBhA+xHVA+A4Qo4AJbNHMaM7HIwQ5Sc66j72MgkDSDqp4csisleULLUqq9Xerfx1Y/QC0/N5k1/7HNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkncIn2U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KlPISdsE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098VFFv3728380
	for <linux-can@vger.kernel.org>; Fri, 9 Jan 2026 12:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4y7QZR0Y9/fOdrnWjQpdxPYv0mAMnGM70MwSvMlGLYs=; b=RkncIn2UTruWCupw
	clCSKllpY7yTzEhrAdWwoVw8weNkIeUOlcUnLzU+gMt6ag5H/GlFLvAcBzHd4FsU
	9M1YVSBOPTZBNSaTPzdr65Dg1BxDHKhWiTYTxpO+d1NmNxdudPyAZtY587Xhk66m
	UIM9NGptQITosuCkjgSSjTun9RUmaaqioXJFpnD3cz83nLGkkFBXn/TBZbMm83In
	YcoZIg7MvVgGIca8Te0tY0CntMROR0nSWt4iXgjNw4KNNMCNrWnC/xBZs/IcKwbi
	h5Jesg4Bvggihay0ZUGl4LKVHUqQv/TW7eE5U76uQVJJkyEiZQX+wcHeo+xSqfE5
	9biG/w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkj3bd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 12:55:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f13989cd3so96762915ad.1
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 04:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767963354; x=1768568154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4y7QZR0Y9/fOdrnWjQpdxPYv0mAMnGM70MwSvMlGLYs=;
        b=KlPISdsElUJ0LyJRFL6dxBltSMc4SxX3TKqO/dMSifzkaqyN8WZn3xaQhLV2i6Eg6h
         6dX1SZ2LmqLbj0ZiEeVp3h/7GkZtRhpO5tMZsIQMcisV1wgXRVEhWI/B+qp0nDcNVrx3
         YPi2BA3GFkc2fJ/zx7mV9Pgdk/ogK6Xrx6rshuCVhqrRDVyO3dqTMcNkiW5U2Ly11nQw
         9bmYdaTsR5a2Su/FWQNZt3BFmRImGV5NzOhXUlMBbNAjVZkJzqopB1j5rEWH/7cHjkgm
         YejDtuf/wx+slak5YmEN2/UZW9PdNXKq2GEwtR4GVXUjntKH24yEYl56xxBnGZdQ25bG
         FhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963354; x=1768568154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4y7QZR0Y9/fOdrnWjQpdxPYv0mAMnGM70MwSvMlGLYs=;
        b=WiGl+SzjuIAPjzaRb9KSiv+ZToqOl4tFKe3RTPmmNHKWM+iYpo2jojeyEX4HazlkkA
         l+/Vp/l1JKurqrloidfVsgN+sx2ZicqtyKaWK2j6KuwemytQv8EJ5bIDr7W2l900nXkw
         IsB312hjQOgjOywf+CYWN+w5Qi98U02M4Xp8SuUSabAXV1d0h/DWBWmSUHKkKqu3AWUy
         pSvbex3X6EABjRy+PghwLbg94esfDQNq0JjBd1VwX4PvHZAayyHc2Xj53l/q51V/vw8p
         XfTGli9hjmZ1oxX0xCWCU9wpZYNFO6TBqLXqj5KpB8kkSf+Wb4WcrMYYX/ADeGByCMUV
         62yw==
X-Forwarded-Encrypted: i=1; AJvYcCVjkZ2JQI1p3O/sIG2TNrvk0d8N4Zm9/j4Nd60P8/xjVNdozYo5XJSaIe9niPo9HSCJqX+sNzelK30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94x4LWz3lzm6ZPS+Ew9sjmSGM/MvQkmmlBYWEs2PFMpnEbUbS
	FzoQYi8SE6ipgXFO9UL53iavxq01UfEKKe0DoIDWTBlDdTkfokUeCms1gB3fBUERm7lnUgz3R3+
	/kX/JqXcQrFdO/Z4yytrIlqE5qAp2u8iBmCLQbUWVNtyrD6AK4cIJDvnMpKj1EPM=
X-Gm-Gg: AY/fxX4vYlZ6W+NqQGKsdTz0Wc8GulbSmbNe+zVGEcEjefM6KbC0bMDJc9UdkL9AyUd
	BbQMJegqbIOkWfKw6ltCLIntUIYhtqjLdiZMvxcueqFWJqjNaM+p/02frnE+FxM5jWpACe/5Cmf
	wquscDLe9JdqhJ7dJjZXSDlOJCYnudGqJjXI8OHYE2DBXXg6DvyDU/lHW7ZqxnG38dRD4SjrO8Z
	X3EI9xwrHC89wA7H3eCEdlrXqsTVJRjpU1fIz6zIXX0+7JDR6Jn1OyKlfV9zgugbGCDEu7h71zp
	zZ341x8pOzVBkAVV9dG6ENeaZXwRt35REuTlvGtOrcBMy7adfw9kOwo8n2M2T4DS3uwCWjpXA2d
	GkMH6CHa/voqVT3/IRM5eIcqSP+YsKenpwxbubiHFqQ==
X-Received: by 2002:a17:902:da90:b0:2a3:e7b6:ab53 with SMTP id d9443c01a7336-2a3ee429ad9mr96438775ad.22.1767963354517;
        Fri, 09 Jan 2026 04:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRvPFaCk3aiZqPxKoB2BhMRvNe5PxgAssVJoc1Z/IpEWtlXCJngS5jtmKYMCSdRK/RKZ6LhQ==
X-Received: by 2002:a17:902:da90:b0:2a3:e7b6:ab53 with SMTP id d9443c01a7336-2a3ee429ad9mr96438575ad.22.1767963354104;
        Fri, 09 Jan 2026 04:55:54 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2eabsm104022635ad.49.2026.01.09.04.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 04:55:53 -0800 (PST)
Message-ID: <76ef0674-ba19-4d91-b243-bb338d5f9d59@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 18:25:48 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: mkl@pengutronix.de, thomas.kopp@microchip.com, mailhol@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
 <jlynppc5lspzcc2pkz7y6jgd6h2l7e6cparntvxnyx5rnfp54n@tymil62yg4go>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <jlynppc5lspzcc2pkz7y6jgd6h2l7e6cparntvxnyx5rnfp54n@tymil62yg4go>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=6960fadb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nFdRy7DZwwtMklkiA8EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: p43tTJZPGKJ3Ks2ilSJfe0RNNKikZHd-
X-Proofpoint-ORIG-GUID: p43tTJZPGKJ3Ks2ilSJfe0RNNKikZHd-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5NSBTYWx0ZWRfX+xOhJwK/YGoD
 V2wALDtDCLARzqlMEr3+HxWGs50g5rgtilPrq4buP2X3bD9nj81rs94VYZ6hvXnobDNTTwj1LWd
 9+JZLDByo6IWoJyl/aMX0qJfZt6/REmrFcAZiXJqbd1U4F6A6AyUgtZzyC1xYzIXIthSnwRcTWF
 PRpqQVMB7oCtZM36L6kaf+/CEfMDrdwjz4LValk3Qs70GmnjexZE4lUbbttU1z1zrW+9mDzPKG3
 Hru4A++ki6uBlVWRilfmfSBJ4w0fgKHluZvYzbWmonrjEVwaPREE93ExBa4y+fbaXmPIJiiTtsr
 GlYmVpRLgnposrsNq/9MxfFBuR7rM/kQK1T7or/8cGKLH0wuE6xsxJCypmzefmaywHXiskD23iE
 QPbaUK14iVTKTSbanUO1aV7s5+K81MfP7swgu2FHnRyK9gSOtgsdUc0iKcweT9upq5hJQfTlaQH
 ZpA1nOM8KmfEhU9O8Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090095



On 1/8/2026 10:16 PM, Manivannan Sadhasivam wrote:
> On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
>> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
>> Normal mode during boot.
>>
> 
> It'd be worth mentioning how you tested the controller.

Sure, I will include the testing details in v2. Thanks for the suggestion.

> 
> - Mani
> 
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index e3d2f01881ae..f2f2925e645a 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -44,6 +44,14 @@ chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	clocks {
>> +		mcp2518fd_osc: can-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <40000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +	};
>> +
>>  	dp-connector {
>>  		compatible = "dp-connector";
>>  		label = "DP";
>> @@ -1151,6 +1159,28 @@ platform {
>>  	};
>>  };
>>  
>> +&spi3 {
>> +	status = "okay";
>> +
>> +	can@0 {
>> +		compatible = "microchip,mcp2518fd";
>> +		reg = <0>;
>> +		interrupts-extended = <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
>> +		clocks = <&mcp2518fd_osc>;
>> +		spi-max-frequency = <10000000>;
>> +		vdd-supply = <&vreg_l11c_2p8>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +
>> +		gpio0-hog {
>> +			gpio-hog;
>> +			gpios = <0 GPIO_ACTIVE_LOW>;
>> +			output-high;
>> +			line-name = "mcp251xfd-gpio0";
>> +		};
>> +	};
>> +};
>> +
>>  &swr2 {
>>  	status = "okay";
>>  
>> -- 
>> 2.34.1
>>
> 

