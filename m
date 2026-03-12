Return-Path: <linux-can+bounces-7074-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN0GJmtfsmlmMAAAu9opvQ
	(envelope-from <linux-can+bounces-7074-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 07:38:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1357326DF74
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 07:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5758304DC96
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 06:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309253A3801;
	Thu, 12 Mar 2026 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJUnzsgT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6P/DtdB"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EE38C40D
	for <linux-can@vger.kernel.org>; Thu, 12 Mar 2026 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297298; cv=none; b=JrIK86QivRCOYGCD/KM4kbkzPm2rIwBmq2dQsneNTVnbC7zAFKKE+62L7IclJvD1VVL3Q+teENc05k+lye4MDM5kLUO7Oi4ny9JTN59pk4jkEyzyP/WsyErh59poYAhGE5zMQ5UIQcyvn0pkwsqhL07ndQ3RHGVliIpgZZatw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297298; c=relaxed/simple;
	bh=FUxUDh7qrm0oeEUmw+VjOZXnXxJtzKNzhMYElE8ggBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP+TKuhLz+NhxlXH7MKp+zGtF2CWWUvN4Hui5cip4+5XgPvBU9plRWIaebjrt52jHxImpAw038ll1uSVipgFV8VW6oIny+yjOtN+xLt0BeywzG65A8pONleGKN+CfWBVkM/lY0npM3bpA69HBKsMrhY+D1iXYLM22i8xGxG2+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fJUnzsgT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6P/DtdB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C2chud1594480
	for <linux-can@vger.kernel.org>; Thu, 12 Mar 2026 06:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gx9so5/H9hADS1SBta9ddxnmlLWWD5M+F9fr6sL/dgI=; b=fJUnzsgTR1TwQO7b
	fRFP7fvPGypOcU9Mps1AUjaykGTNGki9KobVoX09LAwwxETI08UCbhhWDiwdYVeQ
	U2NC+PwBhb66oMxrq6yTraQ91XQee4vmEuj66eB8Bhjt8PoR93CJynkuGdTqag24
	flrQsP94HIA572XJR+kQ2Il1wk9vjM+GqpMPTLNsCkvMWnuSBHsyWwrhFqcBCFfU
	qiXBWDYQgQNjTeSJ9IEJZgtyLEdDRdWh24QTZuKZkJUdgW3bniqwpcU4KFOOECbf
	7Rsw77LKDF0T4DsFhawV2dDR0IIrZd1SCT+931qJGYo//rFLnK358aDdU0W2Pq9i
	qaRLhQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cumvq8h3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 12 Mar 2026 06:34:55 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so3677748a12.1
        for <linux-can@vger.kernel.org>; Wed, 11 Mar 2026 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773297295; x=1773902095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gx9so5/H9hADS1SBta9ddxnmlLWWD5M+F9fr6sL/dgI=;
        b=U6P/DtdB08TBVG+0qap4aKucdjVuGRa1dDzMx7flcKNQvze0jkoY9OP+vvWW3J5JzX
         Sn/ERjwUHSu36uacF1w4SqFCI9HcYwowaJRs693/alshyNnQnJjGBumS1weixLwaVbyK
         cUrbiBKojpxW5SWlP6PP/cpF3P+ZkeLN7xns5SZZrt0chKheCv+wM3hPOuFiM4uQ09cH
         OVtGZfbjQ+VYIwAjXfWRWGExOEmPb/ba+ofNJwitpS7FkI9Ad9U3+HSfVg1oqvHgHICO
         W4em+fXTja2lHb7eTWfzkEnI1EMEiZYCRMHH0Yep0mYDn0vbNIlEqS2F+52ZYWbzQBsI
         7L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773297295; x=1773902095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx9so5/H9hADS1SBta9ddxnmlLWWD5M+F9fr6sL/dgI=;
        b=In7XgScjjlNUwZGZH5n2257AP04t9VPixqeFzMsS2fzaLj3vMKCYvPtfxY9Qk8WLi/
         CqcwAIOV4V6cQD7WTSWRCkSCgQkTSe9F86lxbMXFKZGlAtq4jg8DuNLoLOpjaR6DtQl2
         cTCsA6ZdGkRBjstw6QGtTO0CH5Er62dxryWc/5UDEjhQWj3PX0cFh4z3aZRxSJ3YKosh
         REooo3jU/tz5sMoNg81xBFsPQ9Ipj395jv9JLK87GTs3r6mtQSk0a/nX37RD2hwdKzMQ
         xRcAu6SaFvbdFcKrpNvWJ5Zyvg3v2E2N4t32REhAlICmtdi4gGEk1L0B/mX4uqELuu7t
         Ti1w==
X-Forwarded-Encrypted: i=1; AJvYcCWctc0MwgqJgQm3Y4auitgNPYExiyGgVywnYOumy880CWmxwqUStO5+9c2nDhVgvIrPZmvMOaiOdPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzic/u2QDrUZ7XrD3GC8oJRpFuvKQN0g6VB5vv+LUy//75w5d4+
	He3kYrc5KMhx/Y3cpttd8z5urWBxR38aNoFnqFPwPYH3+yNsvl+csF0nrOhK3ANVzU5eBRzDrOD
	ibWsEYZJpmM0VTkqO6bYQdJUxH/gpkGxl62knihiaSaNQOHPW1SBEleMhLrnH3/Y=
X-Gm-Gg: ATEYQzw5TDIV3spdxW3YnFNBCBKXEphQAHqG5aZ7kznI+kKscCNicy9iuXzX7tFle0o
	uyFgfPEAYc3dZpooVBOTxAj/JDV1ydHf8O9xYMqFNBmquzxHNPviX0PY+DbD0h9bWNKMHXYQPa0
	eJ/gWsfaTz4A9roTGFUdkmGlH0mstujM5oensLUKclH4ag2+Hk8HneYhwxPqdslcSUugtXkdi19
	hNJ8KnPHDheYNLJqmNPZxqkSb1iB3x3/d1S2tljS9IuyoQZL7s1x92PUpxqKNBMuyMuueX34amv
	Lv7Zhwq9eVHjVubn3gRdiaQ6VGgLgddZXTicGguTi/phsQEoWB0tHvbN7gBpOksnfoWOvlyxKMF
	wuB4ogYwuXZUIaWqKLeTCuhHly952jAI6iULlAuPoU8CwCDOfEV/0S50=
X-Received: by 2002:a05:6a00:1912:b0:81e:c5a:8c25 with SMTP id d2e1a72fcca58-829f7150647mr4231808b3a.44.1773297295223;
        Wed, 11 Mar 2026 23:34:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:1912:b0:81e:c5a:8c25 with SMTP id d2e1a72fcca58-829f7150647mr4231790b3a.44.1773297294709;
        Wed, 11 Mar 2026 23:34:54 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.235.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072612e2sm2132526b3a.21.2026.03.11.23.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 23:34:54 -0700 (PDT)
Message-ID: <0bf0a64c-0f05-49ea-b7a2-e1b1345a3d7f@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 12:04:47 +0530
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <465ab63f-3d0c-46f7-a08e-cdc5fc26b600@oss.qualcomm.com>
 <73nfsa3r3isf2shizemroctjpleya4wnnel634g7b5qyvvmze5@vre6wrdxxpet>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <73nfsa3r3isf2shizemroctjpleya4wnnel634g7b5qyvvmze5@vre6wrdxxpet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7EOp3ch8Big4cfH4WhR0xU-WmI8MXyGb
X-Proofpoint-GUID: 7EOp3ch8Big4cfH4WhR0xU-WmI8MXyGb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA1MCBTYWx0ZWRfXywGs9RfpOssL
 ++upB93kSJOdvTALDxce6uzvNWH7h3az0PT7TvreIlv2d4zpuBXRFVb1QgfVtrSPf/xaQ8IILkn
 IqaL173JBhxVf7sc8FJepa00j5d5yqTJ6dmN3zX3uiQdB+lRpv2GQZ14UxMr4y53pN90Pn6Qsv2
 qKxvHwOvo465lpezurVyCDWRy56odmRH+qyOJuaLTRw5K2QLwHfQZa+HmTcPLEFRbA7sfI0MChw
 fPRJ7+//nCtXKAWIpH0kZuE1Ki/6eX54DRC3jtqHehENMvNzC0I/P2u9oUS6FUPRMjwP1A8Yonf
 /9yPisOHpUnuhvTg9gWXso5KJZIGlhBU1XjiEbvGwiTQQicvacgusto+458+DS3bGJolVkIU362
 hsV87VVAPtEL5V70Zi/vNWruaWDsxH6Zm1Y+vgAbth6FFmIyI5GthksQTI5H23PFuXaDpSP8C74
 lEMk+W5YCo5D7wyEGkA==
X-Authority-Analysis: v=2.4 cv=ccHfb3DM c=1 sm=1 tr=0 ts=69b25e90 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Kc38NYG6zNWDZ5XZA/lzmQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=GPwEFdiLN6RVZEhl-y8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120050
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7074-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1357326DF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2/18/2026 5:49 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 17, 2026 at 12:15:12PM +0100, Konrad Dybcio wrote:
>> On 2/4/26 2:09 AM, Dmitry Baryshkov wrote:
>>> On Tue, Feb 03, 2026 at 05:07:11PM +0530, Viken Dadhaniya wrote:
>>>>
>>>>
>>>> On 1/19/2026 11:59 AM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jan 19, 2026 at 10:21:37AM +0530, Viken Dadhaniya wrote:
>>>>>>
>>>>>>
>>>>>> On 1/9/2026 7:35 PM, Dmitry Baryshkov wrote:
>>>>>>> On Fri, Jan 09, 2026 at 06:23:39PM +0530, Viken Dadhaniya wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/8/2026 7:33 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
>>>>>>>>>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
>>>>>>>>>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
>>>>>>>>>> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
>>>>>>>>>> Normal mode during boot.
>>>>>>>>>
>>>>>>>>> The main question is: what is so different between RB3 Gen2 and previous
>>>>>>>>> RB boards which also incorporated this CAN controller? Are there any
>>>>>>>>> board differences or is it that nobody tested the CAN beforehand?
>>>>>>>>>
>>>>>>>>
>>>>>>>> The behavior is consistent across platforms, but I do not have details on
>>>>>>>> how other platforms were tested.
>>>>>>>>
>>>>>>>> On the RB3Gen2 board, communication with the PCAN interface requires the
>>>>>>>> CAN transceiver to be in normal mode. Since the GPIO-controller support
>>>>>>>> was recently integrated into the driver, I configured the transceiver using a
>>>>>>>> GPIO hog property. Without this configuration, the transceiver is not set
>>>>>>>> to normal mode, and CAN communication does not work.
>>>>>>>
>>>>>>> How do we verify the mode on a running system? I have the boards, but I
>>>>>>> don't have anything connected to them over the CAN bus.
>>>>>>>
>>>>>>> BTW: can you recommend any simple setup to actually test the CAN bus on
>>>>>>> those devices?
>>>>>>>
>>>>>>
>>>>>> I tested the CAN controller using the following commands:
>>>>>>
>>>>>> 1. Loopback Mode Testing (GPIO hog not required)
>>>>>>
>>>>>> ip link set can0 down
>>>>>> ip link set can0 type can bitrate 500000 loopback on
>>>>>> ip link set can0 up
>>>>>> cansend can0 12345678#1122334455667788_B
>>>>>> candump can0
>>>>>>
>>>>>> 2. Testing with External CAN FD Adapter (PCAN-USB FD)
>>>>>
>>>>> Thanks! It's price doesn't make it esily available, but it answers the
>>>>> most imporant question: by the USB CAN adapter.
>>>>>
>>>>> Did you add
>>>>>
>>>>>> A GPIO hog was required to configure the transceiver in normal mode.
>>>>>
>>>>> I'd phrase it differently: to pull the transceiver out of standby mode.
>>>>> By using the GPIO pin you make it always stay in the normal mode. It is
>>>>> fine, but it is not optimal. Instead a proper solution would be to use
>>>>> the MCP251XFD_REG_IOCON_XSTBYEN bit. Could you please instead implement
>>>>> support for setting that bit, based on the DT property.
>>>>
>>>> Thanks for the suggestion.
>>>>
>>>> I tested enabling IOCON.XSTBYEN, but on this hardware it doesn’t bring
>>>> the transceiver out of standby by itself. With only XSTBYEN set, the bus
>>>> remains inactive and no frames reach the CAN adapter. Clearing LAT0
>>>> (driving GPIO0 low) is required to put the transceiver into normal mode;
>>>> data transfer works only after LAT0 is cleared.
>>>
>>> Why? It should be doing exactly what is required. Could you please check
>>> the voltage on the pin with the XSTBYEN bit set?
>>
>> If I'm interpreting the datasheet correctly, XSTBYEN only muxes the pin
>> into its function and does *not* actually impact the operating mode,
>> which would match what Viken is observing
> 
> See the "Family Reference Manual":
> 
> Setting the XSTBYEN bit configures the INT0/GPIO0/XSTBY pin to
> automatically control the standby pin of an external CAN transceiver.
> The pin is driven high when the MCP25XXFD enters Sleep mode and driven
> low when it exits Sleep mode. Standby pin control is not available in
> LPM.  IOCON is reset in LPM and GPIO0 will be configured as an input.

I measured the standby pin voltage with only XSTBYEN=1 set
(TRIS0 left at reset default of 1 = input): the pin is HIGH
(~3.3V), meaning the transceiver remains in standby.

The root cause is that after reset TRIS0=1 (input direction),
so the pin is not driven. XSTBYEN=1 alone has no effect while
the pin is configured as input.

Clearing TRIS0=0 (output) atomically with XSTBYEN=1 fixes this:

  regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
                     MCP251XFD_REG_IOCON_XSTBYEN |
                     MCP251XFD_REG_IOCON_TRIS0   |
                     MCP251XFD_REG_IOCON_LAT0,
                     MCP251XFD_REG_IOCON_XSTBYEN);

After the above change: pin is LOW (~0V), IOCON = 0x03020042,
transceiver active, CAN communication works. Verified on RB3
Gen2 with PCAN-USB FD.

Should I send a patch implementing this, gated on a DT property
such as "microchip,xstbyen"?

> 
>>
>> Konrad
> 

