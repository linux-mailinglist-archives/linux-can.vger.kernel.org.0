Return-Path: <linux-can+bounces-7303-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M4wBiluy2npHgYAu9opvQ
	(envelope-from <linux-can+bounces-7303-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 31 Mar 2026 08:48:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DDA3649AD
	for <lists+linux-can@lfdr.de>; Tue, 31 Mar 2026 08:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1D3E3067B33
	for <lists+linux-can@lfdr.de>; Tue, 31 Mar 2026 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AAE3AB291;
	Tue, 31 Mar 2026 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXloRZLb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RzCE5sHF"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC536EA9B
	for <linux-can@vger.kernel.org>; Tue, 31 Mar 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939537; cv=none; b=mfwCLgbLWuGQ9AlrUIRckB0Kso409ec5MWgoaH55pBIQ8byxa0w/Zao5lkJitkH7zA/KqYsf8u4qfCZcEmNVPDTfJOPluTilLV3Zri47wMXe4bM/KI7VcS80mXQcT90AaSmHd4WY7Ua6EsZ5N8VlY/kEg4QOHlcVpDMhldnk3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939537; c=relaxed/simple;
	bh=AAYpfUYmdTX3UTjTYSt9G/mxz7kuZvKipqoN5YlKOZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=id9Thi0FPUlBtgOJ0YxEpsCtIciK7G3yaA33szjWh+NnkXAEIH8MXnkr9pCRjxCLNHG+RXsqjaGFaVQe1obg1kjyPPoNwx9+Wh0GlABbjkLlisMIYP+0CFYKlfVC8raB+iKnK9FdQeklelDTAvU6VEYdY3JXc3ss6yCzgWPug2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXloRZLb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RzCE5sHF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V18vNj3174072
	for <linux-can@vger.kernel.org>; Tue, 31 Mar 2026 06:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W7jaa0+Nk54b7c/p08jJcjBJvqBXf72h9gReh5wVjVY=; b=WXloRZLbD35kciMG
	tdq0m3CR61bZQyntpZgknAmIpi9avqS7uK4+IjZbRIO5+yJCWSCS37PBqxXHZzIv
	+sCF6JRl/L/5uWFWfUt5PP2WI0rL34tapGkdmi5f17qfhJlDhXc+vWewsA+wFh89
	M70afv3gxUN9T7nn1RQOsvwYeiaf7eXMsrPOi4gq9XthH36H9OkK6jdYty5yzBhN
	/BwYfq5x/i7MzAj6DFwqTqhcVvRO6aHnAn9VBuPKueD2iF7tCC/kZDKsFTCjZ2/Y
	KmnMkQiAYOCXPf9pw/toUsnwCDRYd8opPQ+m0YeB0anCqpRXgCdxaYT6NN1RhBL5
	gcVqQw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q9h41ys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 31 Mar 2026 06:45:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354490889b6so11382639a91.3
        for <linux-can@vger.kernel.org>; Mon, 30 Mar 2026 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774939534; x=1775544334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7jaa0+Nk54b7c/p08jJcjBJvqBXf72h9gReh5wVjVY=;
        b=RzCE5sHFSNeEDxAOFraXHqkSWIhDzEBYvAQtt+yvBjTl0iI50nERoBjJN80FgoqJsA
         oFWm1kMscy3P5e43G5XD9LR65BH5MrxqShi9usqSWRErpxppMENjw5kHxoOTCsJLjma9
         Afz/QKbaNNxC33BjxtgkbsT4F/bRVry7w70ySbkVVFigQO8GlqptpadMMqXzgvYuo/Qe
         DOGPodSoQn9JNhsnL9N26ODDZChesdU0i0U/+rwGXziWbdC0PLZP8Fj926x4A+HT1bp2
         rzfG86rIWcHvO2q9nNfWvmn3Q7nx7RQCMLOIshwKSMgyPposj7Cyr+Wlksw0g2AziL6P
         gVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939534; x=1775544334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7jaa0+Nk54b7c/p08jJcjBJvqBXf72h9gReh5wVjVY=;
        b=EmoRLR9yI9F6iGUNXYrAu+n4KUy7bXk5qQHNeUC6qozsY9IogFZ44gxVrM1/u4Pz2o
         hAXImn1Yu5EwOGZ3F8wkSMpYSXUrTAASrZnJ44Is08BcjAR2q0NwYNMoUSETqUgl3+2o
         abSbyqV4sDOS4hS82otCRy0TX8zHIIkVFbwnOTEWWN53/513aJkjzr+qPqSku9z7hl5S
         7dJSHGCFxhQjiTze36xgNdbtreTZeH+qI6B/5ScHxVGexIwtlsIy7uOH52WntM3gO81c
         KhjIdUHDmz+ono270/EgPIqdcnmnb54Q2hsxcXicVKBAzzca+uuKHoMS7MZjQroxY8ki
         NpAg==
X-Forwarded-Encrypted: i=1; AJvYcCU6R00p/BgZi8pOyigs7ANsmVIs6ty25kCn6mrWZCtnFKXl51WKLO9/Yp+dt6MCXwXdSVRn/8O2gis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEisyTaNhB801TDd0rx68UOhbdcm890A8TdvNPAbtypv5UhatU
	LgLuCx169x7pzPBCTW3NzmUNvwNErnvp+2NkSrvtPSIENCLxIwLeSgQFwmrX7yAjwXEJxPlm9fx
	ma9skY/8MJgDugAVsktPtdVnLzSrD9VVc0Jo2eisd5HdF6pCFsGBOeVVzQA5vWp4=
X-Gm-Gg: ATEYQzzRhdbcdZSjRFoHnGBMscdd/8Spc+dxVdC11bJ+AU1Qd2albFhBXk1IEjSa8z/
	CNA5ZixZ+4DH7XWc7DyQpwW8NslgjV5bI4ynhFuV+PaoITTztPhx60pMUxfIOO7Vc94TJ2zwNoW
	FzNWXeLBoAALf9AaEo6Fp8I/9tchqsXu4Hl3VVD59Gtlva5FlnCFl7pEDRQPa660hCLp4tVFFTm
	t2ydVSGtl6HOYLwxPYT1NmAm0EwFKsvoOlBVp0w8JXe/DUcXdwfkOUMbIUW6ER7c9Aab77TufP9
	IvJJNCN7YsC+nezN/rsO4Ciey3YYYMogaro1Ob7KF2gmZM2f3pHaQgaaMgzjqLlpvS21ZijHhbo
	4vV35ToLez1UmCCvAe9zMiU/216PYlpnR8R73Fta7OCHKi1L3oIr/rA==
X-Received: by 2002:a17:90b:558d:b0:35a:329:73d8 with SMTP id 98e67ed59e1d1-35c2ffb03bcmr14593891a91.4.1774939534161;
        Mon, 30 Mar 2026 23:45:34 -0700 (PDT)
X-Received: by 2002:a17:90b:558d:b0:35a:329:73d8 with SMTP id 98e67ed59e1d1-35c2ffb03bcmr14593862a91.4.1774939533671;
        Mon, 30 Mar 2026 23:45:33 -0700 (PDT)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe959358sm505729a91.13.2026.03.30.23.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 23:45:33 -0700 (PDT)
Message-ID: <d4e092d6-5d9e-49a4-88d0-c02e2f17f36b@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 12:15:26 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: can: mcp251xfd: add microchip,xstbyen
 property
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, linusw@kernel.org,
        brgl@kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com,
        anup.kulkarni@oss.qualcomm.com, Conor Dooley <conor@kernel.org>
References: <20260321135031.3107408-1-viken.dadhaniya@oss.qualcomm.com>
 <20260321135031.3107408-2-viken.dadhaniya@oss.qualcomm.com>
 <20260323-bonded-ranging-c9f9c4d0aacf@spud>
 <20260323-artificial-ecstatic-collie-047169-mkl@pengutronix.de>
 <20260323-surname-osmosis-3cceca19c824@spud>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260323-surname-osmosis-3cceca19c824@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA2MyBTYWx0ZWRfX9jGZqSsgy3MI
 RsrrMBa0MANWYzryJBRs7Sopo4rPI+9D2iMRaJYwE3rt1hb0EvMgL0XXk2seRMtomh/1h5xBdrP
 E+hk3CKXUZAsdmkB3hZ1BEGnlyUcRD6dSz0PuS8saOHo4Ki6Bt+Vt5t3wxTyYFtv+1koGBQp6Gp
 +qKCdcEL387qiIj1dC/XPsPDDAoYWWZJ2a+U08faU4eOk66Rq5fCMGBTGa8nedrTvbAyiKK6Ykz
 sbNMv/1rl60MqUoMW6zAI+3BxJ1TPxtcv7xx+PxhXwTL5cgih/OwTgExQSgjayAJGYm3PuqXJvE
 P0pheDuVfJm6cl6XC5OlYu4wm1aqMLTJpUXuk9ISZSdP107IFXwiWHYSIWuKpNI9+bCIV3d/MXl
 CHmqZ1uKYMW4NIQhmq46m18Y/P2eZAlIkdD06OXJz2E8Hfx0mqzXcESTCmvjvgpNyCCdXbw5wsk
 oeT1QCwWp5dYaJFENUg==
X-Authority-Analysis: v=2.4 cv=AZS83nXG c=1 sm=1 tr=0 ts=69cb6d8f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=XYAwZIGsAAAA:8 a=CaXaFvdgtWsuPFoOWtQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: WtFL0vL3Cry8Dr61ThyA99auWNXrbJM9
X-Proofpoint-ORIG-GUID: WtFL0vL3Cry8Dr61ThyA99auWNXrbJM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310063
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7303-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82DDA3649AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marc,

Could you please let me know if the driver change looks acceptable to be merged?
Once merged, I will proceed with posting the device-tree change.

Thanks
Viken 

On 3/24/2026 3:00 AM, Conor Dooley wrote:
> On Mon, Mar 23, 2026 at 09:37:24PM +0100, Marc Kleine-Budde wrote:
>> On 23.03.2026 19:30:00, Conor Dooley wrote:
>>>> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
>>>> index 2d13638ebc6a..28e494262cd9 100644
>>>> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
>>>> @@ -44,6 +44,14 @@ properties:
>>>>        signals a pending RX interrupt.
>>>>      maxItems: 1
>>>>
>>>> +  microchip,xstbyen:
>>>> +    type: boolean
>>>> +    description:
>>>> +      If present, configure the INT0/GPIO0/XSTBY pin as transceiver standby
>>>> +      control. The pin is driven low when the controller is active and high
>>>> +      when it enters Sleep mode, allowing automatic standby control of an
>>>> +      external CAN transceiver connected to this pin.
>>>
>>> What I don't understand from this patch is why a property for this is
>>> required.
>>> Why can't this mode be implied from the lack of rx-int-gpios or
>>> interrupts?
>>
>> The mcp251xfd has 2 GPIO pins. "rx-int-gpios" is for the other pin:
>> INT1/GPIO1. Also by default I don't want the controller to drive a pin
>> in a certain direction.
> 
> Oke.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>



