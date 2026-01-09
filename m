Return-Path: <linux-can+bounces-6077-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DC5D0A690
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 293CC307B51A
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240A35B13F;
	Fri,  9 Jan 2026 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KgoWrSH1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cj0C6FLD"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA192E8B78
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964237; cv=none; b=RSaWwj2ntxEtSr/E7vDlvg5XotdphE4fbasLgXaWaYmapwnBOK+gKocEmzNhSPklPpL2NpgqhZkOmvuvW14l4D74GM01kV2nwwoGOXSs5pG5KXVWpk37lvT2Pl1BhotAUlh0TUk4IONYMIKg5j5Ps2ZgPap5Dd+qUb0xPR2wgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964237; c=relaxed/simple;
	bh=niAPPiQQQPX1D5kNh+Jjyf6MXYDSDaZSYDRJGQC5eJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZcTMkxqwbnV3acx2DZXfNGvC1ZI6NJ5Kzx+5X+o4kWUGZH0Xl7qHi/ErbhkCSg9jdG7RLYmsfizUOjqArL1ZVOSSMCI412lbjdB/6rWItV62hhzRTBVFZ0U+iN8Fx752S1b0rgw5uHuuqNakCoBhlxTz9qG/YenqQ9XydFBatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KgoWrSH1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cj0C6FLD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60982WY52183970
	for <linux-can@vger.kernel.org>; Fri, 9 Jan 2026 13:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jl3U4fYvP7BjbY7tR3WG+iIwGmMIyHgCmvFUBV6UyrQ=; b=KgoWrSH15VfHWdKm
	clYQA0cALEbOxYBeTqOR3dmLQ4zIp7enOHYYtADswN1lgMCVfO4fxxixLsTgeqKN
	fPVBu3u6XxrbRuDicmrsiyV/MfjyEWLgZEBtrrDKSAG6nLeaJtzu0vTpQGYurSUt
	27qPVjr6WtecXVNYTdr7VJN4ze7hba023oDUPDNfAiBNm7ho3hTWvZNcBO83Smnx
	BCz67MPqHebdQyGEjWdf6kI1SCkfYlbfsMUiCWORnFIrJl73R54bzOpJKMlh+2qF
	FYZ2IkdYRf9Swy+RcniHw7r1ky1hXcw8vk0CvjkyZYiqhyPHqNtLYUAPFtkoIRI2
	Dn3/nA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjwtn8x58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 13:10:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a08cbeb87eso51495025ad.3
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767964234; x=1768569034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jl3U4fYvP7BjbY7tR3WG+iIwGmMIyHgCmvFUBV6UyrQ=;
        b=cj0C6FLD4NOuxEIX6tPDJcbH+lnpn9LNKOX687RGUQdrP6+R7J+eJP44ctVp9lLQGI
         pQHzRcTcGd6PXJNAFbpm0NTrL9CHOZBCGbinRx5RiHWqsHQhXrB7thAslU9dAc1SSJnT
         asMWeETUMnZgsLX+aagQrhvzQOiY1RKldGGanoTcAPGOSK8Aux4cdX91aqBmcohqqCMZ
         tl6NLgiFKVHh4y1Ro5w5uwAjwtpA9ybNdCSsitd/Oyzj2Oz1Y25gjzfNYFu4KRtv8CiP
         AAbqYQn2gqYiqEUzem0zOjXJnzRqy2dZ5zGcf580DQC1ZgfoHALrR35pPviKkwJmxu6p
         FJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964234; x=1768569034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl3U4fYvP7BjbY7tR3WG+iIwGmMIyHgCmvFUBV6UyrQ=;
        b=iWT5ji6/jFxUZFMzDyIvi+4UDD4PkVBK114kOJspvWRM61xpka1mKiwyhML8TmXy6n
         NBTuuiYqbtDvtVw7cXJOoD9CnWww04+H24ET24a0jRkXzvzFqiM9/dwPsDrSn2TIHlrN
         GtFJWr1wg+bM5hMpmudtwyVKmeYt4nH3cY2QzOwW7pfsSKLOam1xjM0G2IWSkCljfRQT
         MZzszXEMt4NMjyfYHzuRPkAzceVMqU4b4sjIGYtlvhNx5Zt1wEvEdt8HSEFv5feqNhFZ
         JfPfSUGqa5xASwbircep55wLwzrRXaSYqP1WSi+Qp4IQJC05f+IJwuUBzFjT9RxvO8X4
         X19Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqazfmNMKPEJc4Vrfu8jN8DwuKHCr73iKtY2ir0pFYgax1AbzwIpejOVngTVdgVvRG3gmojK/Xq2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiR3ArtPrcl8edguZlTVNTAP4PDDnYA3YQuxfLY7QgGStLQ3k7
	NYC6e2OeGKhnnMG6Y4SadMA+01A9Lura3trUI56cB4qqhvB43flotYdxt+HkULKbEXLhuNAkd1X
	rM4d8UxHWdJ4gF+KwCbgThx71CXmJl1foBjp5WxXYb9RudpiVl8tKAyY+Q8h3X8Y=
X-Gm-Gg: AY/fxX7iYKpHk2a2ZY57kzW2y3GA4wjh5XhLhf8p/B02Qvte6wO55eg0X2X4Ep4gqUW
	Cash/0Z1KGdmq4q2nRaiy22+yn49lG4zhvcJKWTvYp+kke+yIz/H1JEMvYQj3BmKrPdEYfWGumC
	mOd+69HNGgsPLowKIXAVc96NEOs5lh9mTDq9UyORCMQ5wsT9xuUuIO+mEPDLXKKkjpbMsx22DDt
	nURxAlSbEkbf0WSP3Gp/bfIjuHA6dG2t1NgDht+gIYo78OXXGlmV4PQpMPt3ky1oVVnN3COm+BZ
	tVdnjCGFOMGvZf98jX1ztiHHHJwdYI3GBzdeRMeVEgCloSTHeFno+l0pRxmwJ5qhil5w6GIPECb
	15cS76syW3msMq+CLDxw0euwRgFAXYIV512HnhdLefw==
X-Received: by 2002:a17:902:daca:b0:2a0:da38:96d8 with SMTP id d9443c01a7336-2a3ee443bf0mr100105265ad.25.1767964234120;
        Fri, 09 Jan 2026 05:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrtGRjsnFeOWIo+8GBd5wdKaNe0W+5SXLW8YyqmBR006Uahe80W9Y7w4vCN+q28MK4q8OVgA==
X-Received: by 2002:a17:902:daca:b0:2a0:da38:96d8 with SMTP id d9443c01a7336-2a3ee443bf0mr100104825ad.25.1767964233610;
        Fri, 09 Jan 2026 05:10:33 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2b4dsm108346675ad.54.2026.01.09.05.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 05:10:32 -0800 (PST)
Message-ID: <6ebf45af-2236-4335-a2b4-6c75142bbd5e@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 18:40:27 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
 <20260109-agile-bear-of-fascination-cc4680-mkl@pengutronix.de>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260109-agile-bear-of-fascination-cc4680-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2plUz7mVLMUHD_CBLvyk4hLvTb1hNw64
X-Proofpoint-ORIG-GUID: 2plUz7mVLMUHD_CBLvyk4hLvTb1hNw64
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=6960fe4b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2KV3BzIYt2orMVJPxDMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5OCBTYWx0ZWRfX2AjvDzlGUbNg
 0kXBenfWOAx8y2Q/v8vVfrH0aa2FjW21jrVdMdMCXUKcNtiQGrv/Fkvsuj7cGaDATZGFfiTYKgg
 FG9ASbr7lK8IN+6ArRbioYma/8AqGBJ7XnXr4Q0LmYJrsAAoZOFeDOQ2AqeFoyYPVt/0ev6/v/9
 j0xHYTOksK2IPgSyybN6qMgqPfIPpMoe62h16cG4XX5IIQl7lkIyRAzyDjEA3rY4dbfm51zFWOu
 XI16+uD814jL4AJiBXgIYeSjGoFbIhBHX8qGog6uK2JD7N6bbpspe6EXhuTEO/MjQauTzawi+0D
 8by9SktmI0Z1DCLAmLCeQ50QF4zUii0M8GS9NRQIah6LngIiU6O1ruuTkYz34bw27csAXWqmesG
 YQY3LLjuxNkoEQwcbgzhKRXda51FhmR8RKYwqUyTKV46vn63L7sBQrAoBQHO29Ja9XtIe4BsbSV
 r42+p/om49b59e/NsIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090098



On 1/9/2026 2:22 PM, Marc Kleine-Budde wrote:
> On 08.01.2026 18:22:00, Viken Dadhaniya wrote:
>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
>> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
>> Normal mode during boot.
>>
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
> 
> Is the #clock-cells property needed?

Yes, #clock-cells is required for all clock providers, including
fixed-clock. For fixed-clock, it must be <0> since there are no arguments.
Omitting it will lead to schema validation errors and may break consumers
expecting a proper clock provider node.

> 
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
> 
> If the CAN transceiver is connected to GPIO0, why not reflect that in
> the name of the line?

Ack, will update the GPIO line name in v2 to reflect the CAN transceiver
connection.

> 
> Marc
> 

