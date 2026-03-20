Return-Path: <linux-can+bounces-7202-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCheOWZJvWlr8gIAu9opvQ
	(envelope-from <linux-can+bounces-7202-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 14:19:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 451BA2DADA4
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 14:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ACC23094621
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589943B894B;
	Fri, 20 Mar 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DHKcB61j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QKfkaNg4"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C993A7F49
	for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012692; cv=none; b=BsCI8gIITHJ2LcNtcAziqLwTIxpZcxDj5txutfaSWRAgqxMdNIQqOQYUfGH32ruDPMcnBncK31KDZIiN9bq5IiAg9wzZH/ddqEShMLQnyT6ZM54tc+5ACfHY05vKd6/h2BBgCqr/5+XKuB74EGmfXShfcDzJTBsh1ccWzPRcvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012692; c=relaxed/simple;
	bh=GFtPOIS2d3ylVKkbDZTigEDzxkx3dmQGhTmUhaceH9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5tkqhIi1Hd5+bi+kMcSnyOi5Ict4z0jkKI5RXC9y8YJVZzBfSRQvJxURaFEKHZG9XfJSRRfSPO+uV5DCcTWYc8C2SHLcfFH+upozRecyoXc6sdvJnLE7NjkU9bS8wfUcmDCeEqY8IQl+j7RiB15U92+qlJLcSQSZf/zC71950Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DHKcB61j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QKfkaNg4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8eYpu1191955
	for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 13:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nN+EpZcfjM4UEYkobqRL5eWDhWbXf0Ts9cWhVsyvUK8=; b=DHKcB61jHehqeBur
	ss7vEYVwG5/86QEBhdc5juXAPznv6NDzswrrwyitGdWZY4seY8+/omgW0UhALkVM
	KUT/Mpkk5vL6xY4TvchmS/CR/4c9yU8SbB+och1eilD+Qo1N+7LRcMSJIJFy//Wh
	TSBaNIxnHhmJbeyLYXv74rew620b19Knd5zW/Ey0ForBmo53M1xE0JKHDwRkVkPT
	9cUH5tPyJAPqztFLviX561xyipwrj35theXNHy+sVE2bqlxp5xjTDw1H4v0g39sT
	+W2Rd4KqxtIGImrOLhd2yeP+5hcNs8819L/z9l9Y2RXPOoRf7E3Q9gYV9jq3yO7k
	rQxsDg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0t7usw39-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 13:18:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354490889b6so8530697a91.3
        for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774012690; x=1774617490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nN+EpZcfjM4UEYkobqRL5eWDhWbXf0Ts9cWhVsyvUK8=;
        b=QKfkaNg4DNPeOmwvjiGfEUTitMe5CcUgoAKAqrG/mf82FU/fO+BrRGpeC6HcWdaU71
         FUobN0E9X5waTYRFrpYvThY4+gUjmkBTmdEDlLdvd+21qPjRo1gHcQM8NF0F2TVqZ/VY
         LBzT6NTYQRBS6wqeAPDXCSLIc9nfmyyAo1ZO1EGUhfwenF1lpAki5s1cKZAZcHb7YifQ
         8suFVNrkeIvYVsUkMcvfeKkASYAdx4Hpjch4U5bXT0TcL6nwMXtfipzp2uo+KcertUMj
         O8TqmQ7V9Bz9Hm96uSvJM09lRKDuXgiqQyLssexD/UN+P5qKULPePOjdwQtgHLNQYXfu
         JWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774012690; x=1774617490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nN+EpZcfjM4UEYkobqRL5eWDhWbXf0Ts9cWhVsyvUK8=;
        b=tEyw6jf8GOpw4vkQOkr7++SHwB9lpFDqFGa2c73Rv/RdcXgTbmalt5oRDjALChZBZ0
         UcjmEhPa0z9DEZhhi4x3zUtoTlV23Wn+PR3AiO7o77rdVvl+VPEd0I67f4PhVIy4npW+
         ZyiqcyCkCdOTD3qeXgJG4epMGjA+bqMmfJMpmnpXcXy1aW2EjhxJCMsxwoE249jhDVfc
         N3cozo/eIzEu1Idb2ptRp1TX7O42LwLT6Gs/L/RmTSijn3iXwIpyBvOvyJ7IW5kUND95
         YFEXooyn+9fVgf44orFoH23B2z4kj3vwOgpmEKPOb040EP64cVEbmAXC/7XgeWspQekx
         JnEg==
X-Forwarded-Encrypted: i=1; AJvYcCUYZKHaIF7KogOjTAZlhbovbhHKNkXUPG2U/hJ/CykWzwnpfdBgN3fDajPY159SOZHBn64UiVomve4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRM5HQ9lZqivkTmGnsyVRnxaKl5iiQj47UhgVQtDeS85u/LP6
	VEvu3XOMd4noUYXyl4/FRA2odyd0O2/vdGw/bd4yLSKCOeXaVPvoc6HyY+Ecb7+AO0yyT6VuVHt
	UmUt0TNS9cznzAqGhc3sxPCXvBjq3B5XJspmi41Da7KHvtN6jKy+jZuWdVf8ytLs=
X-Gm-Gg: ATEYQzwpm9ACwaPWMibKyihIeSbcUkwiuoW88J9kvmFHNlVCm8aiFS+MnZTLtrif2rZ
	IwUvOlwQCPjinFon4uKPRPES6t6fUkh6ZfTV4O4mYnDA2oKj7T1Ku07rbsSYAjboSfH9n/D7MsU
	HFSAqUijdHRLvVqTTsXIebMNAA4RdOp+Q6i5YaHNdkUJBeo07aaB1PSxHzzFnlIugrpvlMZmhdv
	k9IN+vzCpfLHz48uCnZE+fbkTzbmeE8xXH1Q/VajGyao9RnMw+L2rAokoFZ3XBalUgtKnLgrduR
	aCDx33thH2UDYuHrGxh7+O2euq+Krb5cfFCJPv3DJGp3F98Bnm8njDSZcGdV5/LIs72hdq2R43R
	deHh3MCqKbkohlasOwja3K2+5p0XqFupTKz/pNhAhP9lTb+sKGA7JdGjR
X-Received: by 2002:a05:6a21:3295:b0:398:8766:4d0a with SMTP id adf61e73a8af0-39bce9c06d7mr2867287637.19.1774012689405;
        Fri, 20 Mar 2026 06:18:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:3295:b0:398:8766:4d0a with SMTP id adf61e73a8af0-39bce9c06d7mr2867236637.19.1774012688756;
        Fri, 20 Mar 2026 06:18:08 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74487b5b8csm1872880a12.31.2026.03.20.06.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 06:18:08 -0700 (PDT)
Message-ID: <bf9196ae-d03e-435c-9e57-ca053a4a19b1@oss.qualcomm.com>
Date: Fri, 20 Mar 2026 18:48:02 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
 <20260316131950.859748-4-viken.dadhaniya@oss.qualcomm.com>
 <20260316-garrulous-saluki-of-advertising-b0a726-mkl@pengutronix.de>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260316-garrulous-saluki-of-advertising-b0a726-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwNSBTYWx0ZWRfX64kQHRdmAbAl
 x00EooV6w7o+W3yiSL7+VMcehlF8sv4hvi1B8s+Rcc7kSdd4+VN5C+1YE0jrOk3AUiCKmEG/kFw
 wGYC8E0n9onqQC6Z9GZaen5C8W9o76Bjc4QyieEWdt/BhlW2ZapjjsVRq7PrK7GUZQhnLkSBmzR
 WR8wVoXro5aSs64Wf2nk8xaHaXEYg53535adILtdjR17r+0P969viCyNQXeMncimShqHZM9sEA8
 S08uI2qiRm1C4Hl4DabxmuTXFL8AGgX5FjBrIFuoKfczErzZumcekx+VB5a9AdVo/Iyb8Re0uEL
 erC/ZFkpatzrudkOvuqBiXINzaXtsTMcsRlwir7qXPgvlWkNqLWLuSwiiSzkfApI35m2YjGxzOZ
 S+qtoBHLTnKQMxD/M+++u3nF1MmORYVtTtNQYeyvu68Yjt7IrYex7iPKbQ36qlbIHDm5foiqTLB
 ElitDtPbG2g8mJUcCAw==
X-Proofpoint-ORIG-GUID: erd9m2QlIKBNTnTj_cDZ3jKCrrL1NeI-
X-Proofpoint-GUID: erd9m2QlIKBNTnTj_cDZ3jKCrrL1NeI-
X-Authority-Analysis: v=2.4 cv=c/OmgB9l c=1 sm=1 tr=0 ts=69bd4912 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=cGBE/nqsz5+qsjWdF/9VHQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LcWsMGrysshWCZgQONgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200105
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7202-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 451BA2DADA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/2026 6:59 PM, Marc Kleine-Budde wrote:
> On 16.03.2026 18:49:50, Viken Dadhaniya wrote:
>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
>>
>> The setup was tested with CAN-FD loopback and actual data transfer
>> using an external PCAN-USB FD adapter.
> 
> IIRC a board DT update should go independent of the driver update.

Sure, I will send the device tree changes separately.

> 
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>> v1 -> v2:
>>
>> - Drop the gpio-hog property.
>> - Add the microchip,xstbyen property to enable transceiver standby control.
>>
>> v1 Link: https://lore.kernel.org/all/20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com/
>> ---
>> ---
>>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 22 ++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index e3d2f01881ae..245961722f84 100644
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
>> @@ -1151,6 +1159,20 @@ platform {
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
> 
> Why do you limit the frequency to 10 MHz? Is this a HW limitation?
> 
> With a 40 MHz clock the chip supports up to 17 MHz (not 20 MHz due to
> the erratum).

The 10 MHz was overly conservative. Testing on this board shows:

  spi-max-frequency = <14000000>: actual SCK = 12.8 MHz  => OK
  spi-max-frequency = <15000000>: actual SCK = 15.0 MHz  => FAIL

Any SCK >= 14.7 MHz fails to initialize the MCP251xFD on this board,
so 12.8 MHz is the highest reliable SCK within the erratum limit of
17 MHz.

Will update to spi-max-frequency = <14000000>.

> 
> Marc
> 

