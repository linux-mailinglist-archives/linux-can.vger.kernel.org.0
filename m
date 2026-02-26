Return-Path: <linux-can+bounces-6646-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBHrGlFXoGkNigQAu9opvQ
	(envelope-from <linux-can+bounces-6646-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 15:23:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49A1A770D
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B43C316707F
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433403624B5;
	Thu, 26 Feb 2026 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isHACYph";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eDK06IbC"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60A3612FE
	for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114914; cv=none; b=pKvxWfUB9G/tgYjv7Qv02iD7VQWon0/MgEX2x0gRJ+neSX7TYQIyTxLSfZQa2pYjQLRMbOEQjMG81fU9SMPe2irk2kUfnK5AXWwkvWu3JNt2IxlVTTR2rAvIax2oGNvDIhPpCyMuW2/UZvj/0jZqnn21LvSfOkZfr/5eJjCKqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114914; c=relaxed/simple;
	bh=t1UcEzBGxK0BCz19XygbNTaJZxlF6PDWi/BIFmL6hk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbJuc1+JvIR13lVmhM/kEZJldaS0bp0K02XV10hHzdiR4VgX9WlpNZRomS7ZRNcRVPRO4IafvyMF0OMLoCq0vKZEB2Zk6wvMMjjiawDqacZasl9DLl5Y1ppFYYqMAdWM1rJ/WKrlgUzwKF8VGZbBY9qSi2/Th5CHETk2YInaPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isHACYph; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eDK06IbC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAL2aA1696118
	for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 14:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FiSYMHWATOi0zx+LUFUVIp9vkmisGEX5Df+vL79Citc=; b=isHACYphQ1QkU94z
	m7dlsNGpOoT0RI+TZ4kN/6bUzRnekrB1CNo95oq9AIrX8fdGv8uKt3FvTHjV7zJr
	ruYptkiwpegL1TIU30cmMZGipToXjuXVCKpIyyKpr+BPen00YXbC7Pt+6/iECIBa
	W8m6QlVKWejcBEeibkiQ8B6AUnWDVCvuY9XSTe70lamH+GakECOB/e2o2xJDks+w
	EpVE4cJsTlwiDG0VLazzN/AerP9fzIdr8UaeI9j1tSgVv+lCDypBFUy8fT3Z6nc8
	QyhZvTW8wNA0H84u0+P1r5iaeuegPMllJ7HNiHinIFWQTrV8D3v+XrRYyreM8lQw
	PEla8A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj350kwhm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 14:08:32 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-94deafc3969so13748504241.3
        for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772114912; x=1772719712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiSYMHWATOi0zx+LUFUVIp9vkmisGEX5Df+vL79Citc=;
        b=eDK06IbC8A55pnRdLzn9QidP5TZFpi/moXc7o0hlH+J7Bdm/UFHdPG8j4g5N75cw5W
         7QRXlIzyBCxci5rrzT9SKQq5wX3tF0kxwacVhpAVlxxBA7F3zjckWRx+J9EtN0HH3A7N
         kz6s1T8PyFCFTtGHixMsSsvaRo1yonNfU9ORwmm873qBGP/uf5gPVn9l5EVtSaZnN4RC
         za9gyoqaN0Z841mMAtPSXq2jRdJuS/tsav5EfjNvRgX35/1sw6e3ZwUunjvN8ubig9VM
         LtGxD5FoN7iUXzGduRiWwiPm0NzDEIVpXa0BEMzRTpLLaIxefeOQn6B8Ghk4gPuiCFQ6
         KfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114912; x=1772719712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiSYMHWATOi0zx+LUFUVIp9vkmisGEX5Df+vL79Citc=;
        b=HvxXY6bv7WHWyKtdn1m5aIOeaVqHk/7rwT8x0tdU95g9wCd1PUmf1F8SZ1pKQ+t0XU
         GSxx6TNoetvoerF9QgnPiBzG3+uVQgccFQuedm2sfqkfyXjxfoUklYx6C2cq+/QuIzIf
         LgBA7vPR6eQgbwfUpQUvgf0utNHqDFyOwyuU2I0apJV8166BtqPbmLCLvQ6dDE4f58Q7
         pDYxxd4ZCLvIPDiz580GoEqpAnY+45PjGc7Sd4fO3farhnE16KEE7DumbKexsSjyhMK5
         LVMgaehIhqFUpxO7AfDuo8/spokBv4bvpwj7O+olpmXeNHsCVchiZGHsT+gBP20oPqmq
         MQGA==
X-Forwarded-Encrypted: i=1; AJvYcCWVJ9soCBQws9rwuZqGnip4+WbKjjkpvrQEn+QeYOwVjfv1HZCoOY0jy8AxU67ytDDlw97BIOj9ClE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbbknoLtmXNDmB/IJIwZulHf2yWZc7GnMbRj/HY3okYdeugwB2
	NttkDkPxXUvVk0YtJ++7IYpwg42DZteP8uxaQ+5X9H+0rCRfKRt4jyxGwgAehJGGv4YqBA1jdeO
	o3HVx9VGS9omAWds58bF0pQz96esbvmO0huMYW2d/z3jKGb6G7nxhjWNqbhQtv48=
X-Gm-Gg: ATEYQzz3V4+M1LqeHYcxtjpsZ1pS5z1sUXnghgQAA+67SETVbntQL43FLvL7qoHOXho
	IXoAlPR8hkWcnXYrnHwd9KffHk6Nj+UcughIag80XWLU2DHsL4iNF3ustnmGNaZ7trKUdfurNXq
	X1C+PgjUmoCyPaUGZgIfqC/8POWVv7Ms6aWhBtI+xddLAbA68Uh2Sak/mjgWtt+kG6y+GcLg9fW
	W46TYnJnIfBUyza3dFe+O0sBSRXIqHOHhjFiPhpoeXvgg8IVMIYrdiUR+4rsiNbBEm00+iw69Jw
	IlHQjMctHHfvMoFjYUBr/0GmdImf/nZELFDEN3S8oPDVHHuwkvUtPbVyIjkjdm0HPLfozCBb0+3
	i4pfKM4zksQxWEq20HYGMyDrh8SjV8ml/M64=
X-Received: by 2002:a05:6102:3586:b0:5f5:3dbd:700b with SMTP id ada2fe7eead31-5ff209d60admr1231287137.7.1772114911868;
        Thu, 26 Feb 2026 06:08:31 -0800 (PST)
X-Received: by 2002:a05:6102:3586:b0:5f5:3dbd:700b with SMTP id ada2fe7eead31-5ff209d60admr1231254137.7.1772114911360;
        Thu, 26 Feb 2026 06:08:31 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d113sm471955a12.19.2026.02.26.06.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 06:08:30 -0800 (PST)
Message-ID: <76036b0d-fe61-4d19-a209-65e1a790c107@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 15:08:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
 <mailhol@kernel.org>,
        Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
        virtualization@lists.linux.dev,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
References: <aZRB7Reu/D6HvRcb@fedora>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aZRB7Reu/D6HvRcb@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: R8xY3TdT2wHZZ-yH7zuYbZvInZPAmtPa
X-Authority-Analysis: v=2.4 cv=Zs/g6t7G c=1 sm=1 tr=0 ts=69a053e1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=u91kjjuq1gvM5pTUOaIA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyNyBTYWx0ZWRfXywjZ8+wbzKCl
 TUpzg2gs1kKIu99gRvfE/0xgtQGJZaD+H1rutGU1P8CrJT+fvkPxlhk6TNQAOGPnD9P9hT/0mS3
 4KZAyy+DEQL9wBQbhBbQya0ZK2XWjVFYqP0IqlccqCcptgHgCOEAscfj3fNQbBIbFAWKuXjjEtW
 N3XZ96X83RivfJ8CP9aqXP1gGuwJBQZahHy0yK5kFivr9Kvhro5QmEFVAYd+EvcFRCz3AZMWOqF
 lKiJ9x6R3CGDsN1hYbHRMioA1gCZa/QXawi0LmGBo7Q9cPNndAltFpmFeckvWe7PHFRxxfXBcUe
 U9q3dUHQoyz2eLNeKnlx0+P0dokHug0kk2Ss06Kh53Ncld3mvJnkbI4u6IV+QgIaWT1/yOvACjs
 qowLP+Wx08kb+uLZ6Q4eTxqBlv6Lp+DyI8gM5Dy4yNNtP9P5rFPu7vaG2SWnwnHwFPoivYPWKyu
 3HW5SdwzZMTA7+GZ8hg==
X-Proofpoint-ORIG-GUID: R8xY3TdT2wHZZ-yH7zuYbZvInZPAmtPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-6646-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harald.mommer@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE49A1A770D
X-Rspamd-Action: no action

Hello Matias,

On 2/17/26 11:24, Matias Ezequiel Vara Larsen wrote:

> +static int virtio_can_probe(struct virtio_device *vdev)
> +{
...
> +	priv->rpkt = devm_kzalloc(&vdev->dev, priv->rpkt_len *
> +						priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free,
> +						GFP_KERNEL);
...
We're here clearly beyond column 80 with something which is not a string or a comment. Elsewhere we are also sometimes beyond column 80 but then only 1 or 2 characters which may or may not be acceptable by the kernel community. No idea. You may re-check the formatting.

Besides formatting:

I compared your actual v10 of the virtio CAN driver against my last v5 and and I saw nothing in your code which may cause a problem. Only learned doing the review this way that at some corners my old v5 code was not this bug free as I thought when I saw some changes. Nothing serious because in some "not expected to happen" corner case code paths but anyway I'll occasionally have to take over some of your changes into an internal project repository here.

We will see whether this virtio CAN device will be accepted in some near future for integration in the mainline kernel...

Regards
Harald


