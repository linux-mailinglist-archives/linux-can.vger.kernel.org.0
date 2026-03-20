Return-Path: <linux-can+bounces-7201-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPReOGAqvWmI7QIAu9opvQ
	(envelope-from <linux-can+bounces-7201-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 12:07:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3D2D94AC
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 12:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA23B30177BD
	for <lists+linux-can@lfdr.de>; Fri, 20 Mar 2026 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D1E396D2B;
	Fri, 20 Mar 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+GKJHgY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LkMaIp++"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02237A492
	for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004829; cv=none; b=E4WksRm5K3/x5nMVDJFKfYUxt9P9gU/FHrpgspW9G+MDOTQnDImR3+q/KgmosLL4BNpCjgJe620sp7CMWwcpY3OEh3rdpfJYjztjz69hGlX6WAGqbRtlk235iRaoRkQOZmZ0AWA74SW5ab+wGAuHtGnCgKkCASqVfysDR/Nwydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004829; c=relaxed/simple;
	bh=B55hUfkFveMT32Ta80Cl8dAPy1ySrGpel4O4Bo+6YkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acqkH7r+S40qwgP2yJAkiM14iFWhPmURS7g+Noa2ySg2fKZRUB79Qat/YGRMG+j9Wkz8XgQbfdXm32qaJW8HcIVONMLM6nIn6u+mqyJ9epIDVFyD/ClwKx2rLSo/vZ2XiRw1j4ljQZKVJyUGK5/0PWzsYyQopPB6pbNFOjpiMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+GKJHgY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LkMaIp++; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K2XjF1331583
	for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 11:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7xvazqXNDyIbT1hLpYtPJSBPiuK8QomKnXv/8SY/5TM=; b=C+GKJHgY1InXzQ4i
	Dilt54RZIqkiFcFgrQCqcd+7JttxpnTHO62IVgQPCaJelvyf2s7dgQUhz5j2i9OW
	HBlHv5rPxhJkylWnvIjorNJtL88oHOHtgn/CVo3XyoAATrWAYpYaA4QjfTePLGWH
	ZZwu0Uj0cX+gj+Y10rUkvJfXho3kvEd2svVBlqBXOYYwyv3ffP5BQuVhxRQyzLvU
	4Ta4R8ApzHJP7gv5Yiltl+tln2bMhFzA/Se9bwTLu1aq4y4BQIb8GiOI1sZ5TedE
	YsATdZZ15U+fSV6lWHtKh2QJH1R2r/jPkVJF0BFDu+9OgUMWFmK9qZ4TC5Lj2bFm
	zfU0fg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k083569-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 11:07:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82a8203055bso1062860b3a.1
        for <linux-can@vger.kernel.org>; Fri, 20 Mar 2026 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774004826; x=1774609626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xvazqXNDyIbT1hLpYtPJSBPiuK8QomKnXv/8SY/5TM=;
        b=LkMaIp++G/MD9Ex43cVKR5ByhOPNn4FWwSISpam241xLbA2v29n4oouWx75YGJDcyL
         OohWF92NQLQryYPYVqyl5MuiiTCUNjXdB1xj2+IwgDMp43l449tFn+Cx6Ub5PZdse23x
         caOzMGCofbi51RSrBP6lzRPJwu3/hv8K6gVZE4LYsIObstxOXCL5l4Zu9/Co3jDgJ0QS
         yBabh51zxu0ovZxa/4FEXSH1USKKqmy4DwynBm7TF/b+4PlPBvm1HdcOm372KL5OhxHD
         BPg1+Np6O26GUAFaS/ImY9ktIKnbMXIKcZ7aG6CGI4OBQtqMzNCK06qp2w+eDHCLCugI
         JHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004826; x=1774609626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xvazqXNDyIbT1hLpYtPJSBPiuK8QomKnXv/8SY/5TM=;
        b=OI5EXkdaOOSecd9BqzCAEgT2crm7Bh9dHupiyz78PvWPCYRpBTcmQAlDTOg0DfSRy1
         LZqzzaFmRSGsxkSWFZXv9WT3Hgsgi4cbz10oI4K6GUeLB+AkekSjpzWIoMxvgLMZ5daO
         1yDwSAJuiM5FUvJnB9+ESrPq5QBDy2GDG+lgkgD+fnGvocyz0D5kDEMi0i7SuSThAtoI
         xJQg/Npo91ZkHoh00GXRlY1YDgPlq6x2v6q0IJoJmTfieODWkpLneRfTWE5/n+PClgLH
         RKevq/WSECeHXcM+pA/kDtTEHMz31feHwU9j1ei22MC0iqqUUiGLsPdKx9w6SzFNtdHV
         vDmg==
X-Forwarded-Encrypted: i=1; AJvYcCUHKrj4XNHCSwJNKyWFL8PlyrENT7/YPCuVcaIrCmv1di5r8DeDgouGQM2fKEJ5/AbBSgDOfYZ9zK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmLRT0wmU3Mv1sLON8djs2Y5/fo+2Pm+9eyrNxVV1G0OAFkvq
	8Fqx44rd+dsyyjzXH5ffZBOe0cVP+DWnYb2cbZ2I+7IOnfvQrWAJDXcA7DCULs5r5N/icX2v32E
	mTj5jQMBPro/VAeoIlFCy6vnAqYHmLoPWZg2CmQBEk+EVbb+XeTz9OIetyzmlCUI=
X-Gm-Gg: ATEYQzzbyLTyYDHBAnLvCwmDBme2MqsoeKCxN2ZipG/Fwc7kT6+Ocx35kVHGlo/ZWcP
	SA3By9CV6ofw+8wzelft4pCnOsXUEbiEApt9ta6lt86eTKwoGzgwKPVUXYnEYGmqQkHCdXlEevw
	jM4WDYfvg18uQ7MZvGEH/VKM0Dg5dWT8QINGyoBNZMiqkfKSVja7qoOjQweMtRHtAieF0NNEE0o
	wVvjwBDMSVWDZVZ/Pa+wyBhIPXjdC9d9cHjW4zbOlvMzCLSso/UrZnuN82fV501+EeMfflfTxox
	hzB3BGPsJsW+6WJ+1kUdBSxnBVBXhYtBcXpoTm4pzYuXGQ7qBpLiK3z1Yyp1ivcQG6lA6H1ilMN
	xqbNkW9fX62rG7JLqgpFPRpe56+Kfi2bd6ZynIgzXVhHKr0MZ73kOxdYj
X-Received: by 2002:a05:6a00:3017:b0:82a:5ef0:210b with SMTP id d2e1a72fcca58-82a8c278b4amr1939142b3a.15.1774004826519;
        Fri, 20 Mar 2026 04:07:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:3017:b0:82a:5ef0:210b with SMTP id d2e1a72fcca58-82a8c278b4amr1939116b3a.15.1774004825817;
        Fri, 20 Mar 2026 04:07:05 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm2258389b3a.57.2026.03.20.04.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 04:07:05 -0700 (PDT)
Message-ID: <aaeda234-3f14-4007-b0af-e876c064796e@oss.qualcomm.com>
Date: Fri, 20 Mar 2026 16:36:59 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] can: mcp251xfd: add support for XSTBYEN
 transceiver standby control
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mani@kernel.org, thomas.kopp@microchip.com, mailhol@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
 <20260316131950.859748-3-viken.dadhaniya@oss.qualcomm.com>
 <20260316-fossa-of-extreme-cookies-9c5c40-mkl@pengutronix.de>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260316-fossa-of-extreme-cookies-9c5c40-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MYhhep/f c=1 sm=1 tr=0 ts=69bd2a5b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=cGBE/nqsz5+qsjWdF/9VHQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=lHJVDBzvP0N_sG6QPz0A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: PZ9gaUpJdQeE4thi0W97bFJrq0pEVV7Z
X-Proofpoint-GUID: PZ9gaUpJdQeE4thi0W97bFJrq0pEVV7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA4NSBTYWx0ZWRfX0LGopd5qzEF9
 roNml2wlbxBRL24JaxAz5W23iPde04AxrACqt13OrnarrMBQRXaxc/Bo6Wx4+dANBu2J5oarY8h
 qiLU2o2FtRnc37+Xdfl3MknquWlrMmh/XzRpTxi2yKEF/Ms2ClM4XBlmx118Gtyj/79g0d6U98p
 PcFZ5LS9IDMiIjvPTA0Vd8a5ztp+/a5BCUTg2wUDmR1gxlmY0N0b7u9FvCLMqSfk+ECEjZJARRG
 eynZjH4sYTaBUlPz186t8VXRvrW9UEi6VYqoBeM8QvRUlBPbTWejYqFlTTAcPtCWSRenZjk/n3W
 yE3M9KELNiLjKhoCEoUv2BBXkHdmoFFzqHhbxvCSjkBa+PYaWgfc5UZLvfkfWvpfs4Q8n6TfgK4
 jpSLgX1PPQwuMYaaMLdEDF3EzjKq+lENsB0egOlfvWJjL4vOuNJi8eoBRTkBbQ5SJhuXvKqeBGN
 N1XqR2T5bbjwrv0POrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200085
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7201-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 44C3D2D94AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/16/2026 7:21 PM, Marc Kleine-Budde wrote:
> On 16.03.2026 18:49:49, Viken Dadhaniya wrote:
>> The MCP251xFD has a dedicated transceiver standby control function on
>> the INT0/GPIO0/XSTBY pin, controlled by the XSTBYEN bit in IOCON.
> 
> Please add a check to mcp251xfd_gpio_request() that GPIO0 cannot be used
> with xstbyen.

Sure, Will update in next patch.

> 
>> When enabled, the hardware automatically manages the transceiver
>> standby state: the pin is driven low when the controller is active
>> and high when it enters Sleep mode.
>>
>> Enable this feature when the 'microchip,xstbyen' device tree property
>> is present.
>>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 30 +++++++++++++++++++
>>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
>>  2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> index 9c86df08c2c5..7a152acf4931 100644
>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> @@ -764,6 +764,29 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
>>  	mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
>>  }
>>
>> +static int mcp251xfd_chip_xstbyen_enable(const struct mcp251xfd_priv *priv)
>> +{
>> +	/* Configure the INT0/GPIO0/XSTBY pin as transceiver standby control:
>> +	 *
>> +	 * - XSTBYEN=1: route the pin to the transceiver standby function
>> +	 * - TRIS0=0:   set output direction; the reset default is 1 (input),
>> +	 *              which leaves the pin floating HIGH and keeps the
>> +	 *              transceiver in standby regardless of XSTBYEN
>> +	 * - LAT0=0:    drive pin LOW => transceiver active (not in standby)
>> +	 *
>> +	 * All three bits are included in the mask; only XSTBYEN is set in
>> +	 * val, so TRIS0 and LAT0 are cleared to 0 atomically.
>> +	 *
>> +	 * Once configured, the hardware automatically drives the pin HIGH
>> +	 * on Sleep mode entry and LOW on Sleep mode exit.
>> +	 */
> 
> What does the pin do in Config mode?

In Config mode, the pin is controlled by LAT0. Since we set LAT0=0,
the pin is LOW (transceiver active), ensuring the transceiver is
ready before entering Normal mode.

> 
>> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
>> +				  MCP251XFD_REG_IOCON_XSTBYEN |
>> +				  MCP251XFD_REG_IOCON_TRIS0 |
>> +				  MCP251XFD_REG_IOCON_LAT0,
>> +				  MCP251XFD_REG_IOCON_XSTBYEN);
>> +}
>> +
>>  static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
>>  {
>>  	int err;
>> @@ -800,6 +823,12 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
>>  	if (err)
>>  		goto out_chip_stop;
>>
>> +	if (priv->xstbyen) {
>> +		err = mcp251xfd_chip_xstbyen_enable(priv);
>> +		if (err)
>> +			goto out_chip_stop;
>> +	}
>> +
> 
> You should configure the pin before bringing the controller into normale mode.

Sure, Will update in next patch.

> 
> regards,
> Marc
> 

