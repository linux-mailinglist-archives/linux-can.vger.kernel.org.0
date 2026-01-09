Return-Path: <linux-can+bounces-6075-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61353D0A57F
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA90E3361DDA
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34885359712;
	Fri,  9 Jan 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isagW9Oa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PeJ8+G8t"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8033B6ED
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963229; cv=none; b=e88Bmzs+LxSPeKMqwgG3W0tJi8naX7dw+hNHyN8pSbIjbBq0YEg1vK17tjNSk2QPOLT7sRPMcaTurwxRP+aAJaGK8l4uCKh6Zel0a+dej8G2t/3IUmh76OEt/qRBCmjgXKaUi9+zy+s0zKUpKuqLZ4hZ+FBNKBhdgcioUECwp0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963229; c=relaxed/simple;
	bh=QnYYrlkVYCiOvJybO7kvRZie0Ce4eLvKW8PoPZQrr/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnJDPjTSQEgYQVUeHAG25fRgg68KSg70DLQlVZR1i/cmUlkGAwwIC9Gio8GxFG5UYcsgv9EIsDvIuOuUF1mUrVtl1HxbFt1Qvz4stX2cx5wG/CF9IhbsmVxI3Cb92wPhbv7RS0IW8SN01nN1lPXVDKho8Om9sQNkhlc5Q/r/RmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isagW9Oa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PeJ8+G8t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099XjtA1048558
	for <linux-can@vger.kernel.org>; Fri, 9 Jan 2026 12:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vm/SUKhAk9K8mnKqx93R11C/mB3zc2gCcqEuYGanqE8=; b=isagW9OaX1wmnQQn
	BkJg8gEWx9S9Jnst1tymTCkHCB1Af/PelmcQurgA7IA2ajg/J26NctQnoOvOZyMb
	ydBNQvvXPKr+EjNNRIEhiRSPrKDnyDIazKakg3dCF+yiJdzhRvhQH8k+YfEydnT9
	A4J2lgTPrpN8d+vRxB2x8g+WEXvNLiSRaslNseheZ3UMfj+ADVshcPrtDj1ZLeU2
	qMUv9j5PTzu1D/mNvpNpTvvtnFOXvXrQUQdMUj7YnNSkJ5eUxYU1bszT5tQTX3to
	H6jgSdqzzed6bO4NBclCGeS6/aUI66iaMclYkLKUB2ZhZ9D9zwHMSZv+SVwkY+S7
	iPIQVA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjy5b8hav-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 12:53:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ab459c051so9555031a91.0
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767963226; x=1768568026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vm/SUKhAk9K8mnKqx93R11C/mB3zc2gCcqEuYGanqE8=;
        b=PeJ8+G8tPwW2ecAEzm0R4zhPmUfYptTllxPuLFW+Vi/oFzIIIKFkiEXxV8E8KDucq6
         Rk3vaVmyj/HFf/P07q4ifWmvWvpiPS/b+fdHw5s0+jOmjHx6eEhs3wpxAwDyA3nXFluV
         VG28+XTxJK5aTOIlvN0YbMUi3Yt+YiJrhY+Q2rRG3Y6DIELApjaC7Pe7lZ68zHNQHOaG
         bSpQKdqaCdFa1Ur/ioZwc65zJtM84FJN6Ld2CuWZ7qfOmFzzyOdP573tiwNq+DBocKj2
         cmJz0w07+bsyvWdcfqyP2N5m0dmzlbmpQR8zB+pTqSzMVcfFsdYY7fe7I5PpMrYsQKMN
         zOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963226; x=1768568026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vm/SUKhAk9K8mnKqx93R11C/mB3zc2gCcqEuYGanqE8=;
        b=D3NyOD2XtE1eTY8l9jklwC91A2oT8sRFEFSUEzBjytyBKhyUV8V4SAC5zqLXAhFx1r
         bwmVyIxGYC1uOE65TjpAVUZP4bIiwJxOY+L4Q/Db13iXr6Eyn0gV39Bq673l54hsSe08
         BToZVMvoGXnPXpx9sTuRdSvOecAa/Wfxx4Wqavn824CW9Qp7IpSeX4NvvfhBNAMG4WJA
         is9Bq3trCKnNth3eiaSkfW46gZEVFL9s1B2U2YtWdLvMSUlEOFNu+ifM2RrEha6OY1hG
         k26lqUpH1QLAsycoylQi5hC0tjhrf9khcKi51zLU/rd2BjxVs6lC6xK+S2CisBWbmbNE
         0bog==
X-Forwarded-Encrypted: i=1; AJvYcCXPPhUrrW9m/hpMTBWVm8TItDZ2pc4NJdAJ+fZWWEX890zB4+5PR7UncF0wky5QEhCYWXT9nQSkgH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8BZHsGO3/Y2z9WKmD7TAqIwmfDZE4MbZwtk4foLdkdDNtPKl
	Qo3Sg/dGyKf1Ujwgcek11VaJ4nFq17bGtgcSVLjBM0Cu4dz6KzgmRoZzIJT+9ZmfB4ksnvK/w7B
	sh70l7GU8ezN2WyRloSd0kMmThQD/Y5YlU0CuBAimTzmkUw+oe8WxwPLbsLNjvlM=
X-Gm-Gg: AY/fxX49WsY4MGUJVxhh0lma85od6bv10ZIhDs0EopvdjC1fCTeq9FYw/anwh5BpPh7
	Qn4Ldr02nm19YVzIp7qsrwA9cKEJTyDhZaeBSvuvi68B+olJg1kLL9zLSsCSHQA2ch+RsuNlqMB
	SK8NSup7CO32md1HVLJQuT+04MDnClnCeJKfbb4DVtPLYorZNv51qB6Rye4ngXfo5l9vyfQKoD8
	3Mtb8Us91VJN/OUgS44uVaEeQPWHr67LIOnfg/TIyWrZqH0cIF+5HRfj+Ez1aefzPRlsbbZ0QTq
	ozvwLR1u/MYAFojSmGLr680Swjjl/Tj3QkwI+34yS9qQCOZ5IxSA/iWOYg8Btgcaa4t0fnFGiyC
	8tYIHNcsUOMh6OnsZKdKizI8fiNQCTB8uKS9nqdmHhQ==
X-Received: by 2002:a17:902:cccc:b0:2a0:980a:4f0b with SMTP id d9443c01a7336-2a3ee49c6e8mr110019425ad.40.1767963225696;
        Fri, 09 Jan 2026 04:53:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCAxCgt3csbgYVuO8d3lkQPzp1KHgfQ/XXqrK1SLB1uYiZr92CZeF2Ey6XP0Z1Aldq+GsmnQ==
X-Received: by 2002:a17:902:cccc:b0:2a0:980a:4f0b with SMTP id d9443c01a7336-2a3ee49c6e8mr110019155ad.40.1767963225231;
        Fri, 09 Jan 2026 04:53:45 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c4796asm107201835ad.34.2026.01.09.04.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 04:53:44 -0800 (PST)
Message-ID: <5cdfe5a5-3c78-45a2-886c-768b224ad776@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 18:23:39 +0530
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
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <n6affntgff5wy4xmm255v5h2ejpepicpz2cybcuvsxmry5td6u@jucskv7zrzvv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cjOh6KMkNEJFwmiCEU52HZ5OPaq8C2o5
X-Authority-Analysis: v=2.4 cv=JP42csKb c=1 sm=1 tr=0 ts=6960fa5a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pyxDk7YZ_2sT_cTTTuQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5NSBTYWx0ZWRfXzuA4V4NWefj1
 8OCDgVhmhi/CZh9wzCaNF88H8vQm8gw1uH+e3wj5PoP0x4TNDkMFydHMvYP57l3aEQvwaD6IfhR
 +amJJ4iOogXCG8XEfvYdU+CvoZAJ8YqSB+/yj2CV4PcPwbSWcQVdYIL6UKeAPAJ6iwO74hqVZY+
 Km0JuiKVF+hPvDgBhPIO82JYeTaFdmZE6fv10uYsq06Pp2O+tspFWdFIWBmaqEHik45YwkwLB7m
 hNoOG+TvdXLmaDzz/+ne5FdZGuOi8AO4v1wXGZDQnYbhV5xFYzvWUoSInr/wJTVK2t19640me+w
 j4cwI+2rfGb2L/Bx7VezHvYIukX8oTEP22rjvVvSUnrE+pT9oWCiRn3RY45HUVSPBPifhzM0WT0
 t3z62e6Woa1rgDKC+3shj6X9hQjBmLdiU6Mv9ih8eLd/fm/tsH6H72a0ZoUQVObqx4egTNlbPW+
 kKea4WDIHVJETfyK81w==
X-Proofpoint-GUID: cjOh6KMkNEJFwmiCEU52HZ5OPaq8C2o5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090095



On 1/8/2026 7:33 PM, Dmitry Baryshkov wrote:
> On Thu, Jan 08, 2026 at 06:22:00PM +0530, Viken Dadhaniya wrote:
>> Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
>> The controller is connected via SPI3 and uses a 40 MHz oscillator.
>> A GPIO hog for GPIO0 is included to configure the CAN transceiver in
>> Normal mode during boot.
> 
> The main question is: what is so different between RB3 Gen2 and previous
> RB boards which also incorporated this CAN controller? Are there any
> board differences or is it that nobody tested the CAN beforehand?
> 

The behavior is consistent across platforms, but I do not have details on
how other platforms were tested.

On the RB3Gen2 board, communication with the PCAN interface requires the
CAN transceiver to be in normal mode. Since the GPIO-controller support
was recently integrated into the driver, I configured the transceiver using a
GPIO hog property. Without this configuration, the transceiver is not set
to normal mode, and CAN communication does not work.

>>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
> 

