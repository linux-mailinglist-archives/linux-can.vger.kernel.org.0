Return-Path: <linux-can+bounces-6578-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHxNLs1NlGktCQIAu9opvQ
	(envelope-from <linux-can+bounces-6578-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 17 Feb 2026 12:15:25 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4614B3AC
	for <lists+linux-can@lfdr.de>; Tue, 17 Feb 2026 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB5F300C00F
	for <lists+linux-can@lfdr.de>; Tue, 17 Feb 2026 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17433031C;
	Tue, 17 Feb 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AXqVugyX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9PxTVOE"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B732570E
	for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326922; cv=none; b=nKDTlNsxHO2QmB60nvvW/WGnQuu1S4oXYmc+OfITPL2ny7wrmqQkVvql4ZiH6Bf8HSTLkB/DP3mX6YrDYpZoDRieVMoyJ/VxgCxFZoUaD6cAbzk7DBKiXTLfsmZEf50lBfTPcZ4ozPOoLdrU12yML4lDf9CFlrFBgkS02UyOy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326922; c=relaxed/simple;
	bh=+fijnD0Orpou5zkoCNt/U4oi6qz2glc6GWXMBDIZue0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU97GyXpP6l9dS7rGk03A1m2v+QXCvnM6MEXLX7MNLPd0AFb0upOzXLerktTj24rElslzYEzIxTHMXL0b8uJKKqa/qixru2Wd1KHeGnYLamXS5kBZ7l4Kz27dL/C2j3OJnNZfIjsx4z47TSnbVcrrWJH1sHRNzgeD0gYmQLneEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AXqVugyX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9PxTVOE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8TOJ7048843
	for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 11:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ejYTyEPMYZOCpO/IUcxs5fnrHWD1qqqFGZBOuXIwebw=; b=AXqVugyXbJ27KHzt
	zDbdh9EO+L/lB4uaw9JejUk7XN+ms6SpYxsVurwGGzbtNUKijwxIcPzaSOogJ6Jr
	9LbQBsMtnsYNVOvuTbLq/tX3Pc9ozVPb/jRA6Z/yhUfjhCxGDMx8yz/A1InuObhd
	zV1lkvcp84+Ibr5EIg9mS3pARlqJlG8ceoQbVaT720Cr5lTucpkTHw8cJvkPUjg8
	dJhvFtRe1g6ItZdKsi5Da7kbbryqvMbq0fxKFVcrgg8SzVmuI77jsOz8Ztda2G5P
	6XJclM/BoU4aKzbTTL30AD54v4ah1vimg1id3/1e1LAFBqgXkiS+Mp207aLhAjda
	iwKXOw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d823vu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 11:15:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8954937be97so34136136d6.1
        for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 03:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771326919; x=1771931719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejYTyEPMYZOCpO/IUcxs5fnrHWD1qqqFGZBOuXIwebw=;
        b=g9PxTVOEuYSEalHy1qpd20zeO54nwXwdEfUgdQj57Udyse9hejU2hPloxXNW4z2PYP
         XqbwnFgTwkIPwzUYBd+0e0lff9XG5Td6A+il6b0y2GOq/UoVkKCzVGogwg6/0R8Y8h5E
         OdIcyFmZ0pAm1ItwGyKrBION4+mZIhQpJ9pLJT11NIjX5XgigoMokLIjLKXKwmhXv1Gz
         zw5psafBZLBfFBfns+aLW72GEoKardd18BYrbF1lEMTsnRKC1RyxHaaoQazssyHbVv3P
         QLLo4bJymWjIOPWXIIYEflQWKg06c0uVgU631LSbdklbIgmUkExOwsQpAhN68SGBhrfQ
         IiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771326919; x=1771931719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejYTyEPMYZOCpO/IUcxs5fnrHWD1qqqFGZBOuXIwebw=;
        b=EPkH7qEfLBOCvSJ6/qOgHHlUpIvs9VppwIPYaBp//qYZd28jTNOBaqaizZfCwRL7Uq
         bRDep6volxsuRgCCd20F6RDxGCudvEd42ro/d5cm0yaSBPOOwok5PGfEDqZPZCVJISSF
         ynWrThuFL0HdgG5ePNvwqEMvPqYU63Fcvu8lbsNlQOz+E87uSUZQaNCq/AibXjVOawoH
         N+gx0m+/AkCODCCdCNeeZyOhgpddspCKG9AIvYgXLQq/8lAeFoUmeWBqM0WHig2fIRWo
         Xd5ryrMGp3axms4s52TMOtD5FnfeGLa8DbZn8Tzbhu+lZZ7bMcEgS23leFT1xAiF01iJ
         JVjA==
X-Forwarded-Encrypted: i=1; AJvYcCXOilmgBKMs+ZJ327mPXwI8y6qcor3Cr602IHpy7VDUz1szBfulhZYbC5+XkoDvZScULsLKjZJ7cMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Jap8mk2ikLGZxkjDgZZWc+xWWe4MC25fTxpJDchcCjf4hQzK
	o4rAXVXfnuyVn3dvokyJfZ57j5keSuk6LRgI5K0eJBXKWs62ZypO61BzwIj7qhHnDCnO3YuOzhV
	0/IgEvfj3se1qNMhjStYoYy1fvnS+fH1bbL+j/R+yC6G6Tipgk3oV0hmB30qMR1Y=
X-Gm-Gg: AZuq6aKGUvNa70HFDIpTb/uEUO6yMG7S9WNKyqx1bLH/9lNUkfp4yjHnTbWf4rMvOXI
	mvTIYEjmiOU/KNBGfb0g0cJlBpdzd+g8HC+SejUk7jYXTlSy9BHcK2EcVDv9kJT1FjUg8EBHbX/
	eIIlpHogaj4s2/0diwjeJChhMLkAT6Bo9Mz9RB8ISn11BWfGBS7OkbZZL4dx2Kagf0YZDAO1uaW
	zWCn5RS+cucIrcbsPb8tPJ2VbCmCIoz44Eb14EzxjwTysSm2cZ3xwcgmwHMW2+5pYd/DN3J+9ub
	xlPyZJGHySHQPDwqmq2WntN0np7vez7zH4pDTCA7U5pdQlZFajGoY0dOZ+WO4RoSIumI1RIdFy4
	Q0eUq5+lti9GafOhlp6qv2v2aEVCRc7bqFCJyNeq4OHAs5gCi+mHohdH8xFBwV7tl194vn0LrLg
	2Z2p4=
X-Received: by 2002:a0c:e002:0:b0:895:3b2c:7708 with SMTP id 6a1803df08f44-897346241b8mr140536376d6.0.1771326919602;
        Tue, 17 Feb 2026 03:15:19 -0800 (PST)
X-Received: by 2002:a0c:e002:0:b0:895:3b2c:7708 with SMTP id 6a1803df08f44-897346241b8mr140535866d6.0.1771326918904;
        Tue, 17 Feb 2026 03:15:18 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc766554bsm343137766b.46.2026.02.17.03.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:15:17 -0800 (PST)
Message-ID: <465ab63f-3d0c-46f7-a08e-cdc5fc26b600@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 12:15:12 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus
 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
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
 <316fa702-6cd8-4842-aecf-c176a5a53e2e@oss.qualcomm.com>
 <qvuokwiqllm6zmlzj3pfvziylrr5krjya5rnf3ojeycdoutlro@fl5qukh4vorm>
 <5486697e-d02e-4b12-9a60-99d0de343515@oss.qualcomm.com>
 <2ho25tzct6t7gsuyufyg7m4a2ikmblhukb4uddwc7p35wd6yne@heippz3lh4kj>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2ho25tzct6t7gsuyufyg7m4a2ikmblhukb4uddwc7p35wd6yne@heippz3lh4kj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=69944dc8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=l_9iY-1xcGPmI7VCd-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5MyBTYWx0ZWRfX+eAdhyEaT9Az
 +96w5Dk03CAR/FDx1RzMpDOrgI0fhxhaCV87j3H3R4dfoVKKfhtSj1iByyMp5oMlsqEwe6MS/Kg
 dqxdt/+r/aa40Hk3VIvemv8D2PBZMG5L3Feuz5owjkn8Pkr7zjP+UKhTWq2+M1y7oTVxRThdwYm
 pOl191iEjh75EVB9VODUrWaXFFjKEn78toVAqkgcoLcIu+ZLqWG1eUHhdBCQ0mDR3EcQo9egf1u
 kOeyfnaOzqM+BRFssSuMBCDVTPcScOuuQSNCEx1L3r+J7u4+VduHkpV4Dff4PJYC4otH9haGnc4
 Eqt10ygLKCGwOGhxmI/zKRb0dx5J8VH8hkMU9ER9EPkCEg9gs3omVjRDTvD2GHzuGOBk6/I4jeB
 s3PjQd4kUFNtGBf2O26IXDtBXWd6PLtnCa/Q+rjZkB31HSUu7TYBVShu0YuLSdWE0XaYNYaSser
 ABFTFNLDFZc7gwp4c6w==
X-Proofpoint-GUID: 41l41-SylIkII_FxQn-B-mN5FtsjZXGM
X-Proofpoint-ORIG-GUID: 41l41-SylIkII_FxQn-B-mN5FtsjZXGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6578-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1BC4614B3AC
X-Rspamd-Action: no action

On 2/4/26 2:09 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 03, 2026 at 05:07:11PM +0530, Viken Dadhaniya wrote:
>>
>>
>> On 1/19/2026 11:59 AM, Dmitry Baryshkov wrote:
>>> On Mon, Jan 19, 2026 at 10:21:37AM +0530, Viken Dadhaniya wrote:
>>>>
>>>>
>>>> On 1/9/2026 7:35 PM, Dmitry Baryshkov wrote:
>>>>> On Fri, Jan 09, 2026 at 06:23:39PM +0530, Viken Dadhaniya wrote:
>>>>>>
>>>>>>
>>>>>> On 1/8/2026 7:33 PM, Dmitry Baryshkov wrote:
>>>>>>> On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
>>>>>>>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
>>>>>>>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
>>>>>>>> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
>>>>>>>> Normal mode during boot.
>>>>>>>
>>>>>>> The main question is: what is so different between RB3 Gen2 and previous
>>>>>>> RB boards which also incorporated this CAN controller? Are there any
>>>>>>> board differences or is it that nobody tested the CAN beforehand?
>>>>>>>
>>>>>>
>>>>>> The behavior is consistent across platforms, but I do not have details on
>>>>>> how other platforms were tested.
>>>>>>
>>>>>> On the RB3Gen2 board, communication with the PCAN interface requires the
>>>>>> CAN transceiver to be in normal mode. Since the GPIO-controller support
>>>>>> was recently integrated into the driver, I configured the transceiver using a
>>>>>> GPIO hog property. Without this configuration, the transceiver is not set
>>>>>> to normal mode, and CAN communication does not work.
>>>>>
>>>>> How do we verify the mode on a running system? I have the boards, but I
>>>>> don't have anything connected to them over the CAN bus.
>>>>>
>>>>> BTW: can you recommend any simple setup to actually test the CAN bus on
>>>>> those devices?
>>>>>
>>>>
>>>> I tested the CAN controller using the following commands:
>>>>
>>>> 1. Loopback Mode Testing (GPIO hog not required)
>>>>
>>>> ip link set can0 down
>>>> ip link set can0 type can bitrate 500000 loopback on
>>>> ip link set can0 up
>>>> cansend can0 12345678#1122334455667788_B
>>>> candump can0
>>>>
>>>> 2. Testing with External CAN FD Adapter (PCAN-USB FD)
>>>
>>> Thanks! It's price doesn't make it esily available, but it answers the
>>> most imporant question: by the USB CAN adapter.
>>>
>>> Did you add
>>>
>>>> A GPIO hog was required to configure the transceiver in normal mode.
>>>
>>> I'd phrase it differently: to pull the transceiver out of standby mode.
>>> By using the GPIO pin you make it always stay in the normal mode. It is
>>> fine, but it is not optimal. Instead a proper solution would be to use
>>> the MCP251XFD_REG_IOCON_XSTBYEN bit. Could you please instead implement
>>> support for setting that bit, based on the DT property.
>>
>> Thanks for the suggestion.
>>
>> I tested enabling IOCON.XSTBYEN, but on this hardware it doesn’t bring
>> the transceiver out of standby by itself. With only XSTBYEN set, the bus
>> remains inactive and no frames reach the CAN adapter. Clearing LAT0
>> (driving GPIO0 low) is required to put the transceiver into normal mode;
>> data transfer works only after LAT0 is cleared.
> 
> Why? It should be doing exactly what is required. Could you please check
> the voltage on the pin with the XSTBYEN bit set?

If I'm interpreting the datasheet correctly, XSTBYEN only muxes the pin
into its function and does *not* actually impact the operating mode,
which would match what Viken is observing

Konrad

