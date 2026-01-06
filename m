Return-Path: <linux-can+bounces-6009-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE91CF9CAD
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E85C3044B8F
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6334CFCE;
	Tue,  6 Jan 2026 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBes3I3Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kOLe0SjJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7734CFC8
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720010; cv=none; b=DzcxCRv81QEawmKFr3jgeEVQCr9zncLA/Z04+pdrgWrKFawZa11P/GZPvPdoilRv/H/MX/iv/r7G2cei1ql+19RFuoDosvxSqPIxPb1hrGu6znxG82v5R1x2pHqv8we+c73EcGNqyMnvemrToGn6QKG/78lypa8Z6VoRxNrnUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720010; c=relaxed/simple;
	bh=sTEErpPjp2Z3VcdZBQ3ncsCXdMkyOWbj/MC6CcVmLfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3Dk4WaacnDx4z0sTlfnfQM+43xLyXePJrD4PfK6YaJVf24BmS8xvaUWFkSHIO+ITR/ptuCiWjBQG0KwF9TnkkR4EoNDzj4jv84ls6krNv/qE463AbFq6cjB1E8yxg6taZ73OXpgshD/mBrkf7e0Z+yI6O/eGGmzPo1ssnvAd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBes3I3Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kOLe0SjJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606EffFT322772
	for <linux-can@vger.kernel.org>; Tue, 6 Jan 2026 17:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYQ0RFgsq4v2jX8N+92N2Ml8ilGX8oRxAim8aWpvhaU=; b=XBes3I3YjDgtdZ0W
	m5LMrh+fHz7ExRrnSc9Iw0cqW3p+05ymBAtDC9LKqCZTE4akwK3p3IuOo+Rc/mpC
	3eEhsm4TnttzZbd9wmfQ3jDoGuyJuO1SpwbJLkzmoA8j4szWwhWeSQ926AwlH0La
	OZLiVn4LRIk3Pyn5Kw8a0LgrkhaOcIoJvC7aPJ4VFyxOlzCnQ8t7ADLc4SXtce4O
	ams8WQoi8xC8soU3314Bf5ZIAP6hAlPJUnJyWL9ixVxZlpjg3VoOZUbTv2SEp1CD
	s+h1UqTHn5trdEITD8pq1V1xE2lFv8LPAAvsnCd5CX7sNaTBEr1FDZzSORC6uCyF
	4T/j7Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh4crgg4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 17:20:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed69f9ce96so38940871cf.3
        for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767720004; x=1768324804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYQ0RFgsq4v2jX8N+92N2Ml8ilGX8oRxAim8aWpvhaU=;
        b=kOLe0SjJhxZ+bIzA/XReJh2hfNSosym3esMnCKgK4eshLyjvI848YCpQ2KS5XVl8jz
         uj9OBtk+OZjotVICSwwlx89R7/bsPTrXVrruH4zVlGSQPRF7vzxnmJlpEVTv4YjROZar
         sXiMud2PSLdqvzcT5loDD2lxy5JVnxgl/VSP9xaCZ85zkFfXP11jlLywMmJ7ig1q6eWj
         Sy/2WCqgVcn7P5AIV46eJhqmQc+FUQmyOJSf6dCFGQK6lRHJrvbxfIZv7MtFQK09Xtt4
         iug6Vo93iZKO6OyMcxckFATOq0qPnO2r0N3+n6GPEbhdXdXQ6ztpXJ8uMS70Gl2E8n5j
         mMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720004; x=1768324804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYQ0RFgsq4v2jX8N+92N2Ml8ilGX8oRxAim8aWpvhaU=;
        b=E+AzibTzYtnfN8/0nSlDgaWbKRsq8gbVccICzB/HMZIa0hVb7qfhKk3KQKqrdpymu5
         n6x10AqKs1eT2X1tzQI6iNASispA+X5HAjzmUSX6PTyo8WauGEcPTYTLtvD+eL+0/eBE
         6K4VWBWLp6rcKFUwoBOJ52r+WYv7cbKZryY0Gp4H7XMq6RxpkXpsrLIOQXAZ4vpRDFKx
         bH6rEjblr9tA/T1bjXJNtlk6oSlSwS4q3zIol7Sv0mbBjJbwYB+SAxrpjui+5hQF+Mgk
         OyvmVpcWkFEW2wgPWc7yKtR5hVZVW1NU7+HA5BTWfTJ0i51nttpEYXkVisUZS6fY0VJO
         borQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR1Sn/iP/AP02Uqwg2p4WapdIccsqkeUby80r0Y8K6nfgdD6vcHOVbNHedgQwCmS8GnIeDrAfaYG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4dDWmXCDNsCy9JErVEFlOVzNi7G47MOOoLkL604pM4d2XkqAr
	TS1A/Fts7yeMOlTjNdFVGXAoGoe/QLTnSFW2GPNCZJ+pHLurKLMRYp2hGe5kpuumBb4UAI2hyQi
	2xQBKqWe9ZClzPMpBiBtE9dC2UWPCQzxxJKUzFuo+Meyf6UrNwYTX/M5rAuOBy3Q=
X-Gm-Gg: AY/fxX4yuan1IzlEDxP6GMVXxF2ROD5wnmKouLcn4Wn6cAtPxkLouvpXcJtI0oEcDm0
	RSab43c/r0J5qlxemMTVdEjE42meX8P5O4mKslrYJs0iwCEm2Hp8O+vyfV859eBD3x6Qv14DNwn
	iGL//SSrmVEpId6tcFADLKGQ+2kqW96pU8n6NCjcR4reP9exvr5hRr8wZmhmJJOzqufi2oyhBJc
	vm8hYrsT9Xin0krg6ZcZKQHiHsCQyCEgj7AANsM7tnsfoYj7HNvKZ7sFEExinmM32faQKX/FAdi
	ZXhzW+4vUTn+SQ7Q73DP4MikjfpPb1NPYL0wPTgVYZmTqMXiU0Gjq+u4hS2x1TZsHu+17hIJAIW
	J6fybYZA+3LDaePRsIU2XXQ8=
X-Received: by 2002:a05:622a:13cd:b0:4f1:bd73:ac6f with SMTP id d75a77b69052e-4ffa7833eb3mr49446731cf.74.1767720004357;
        Tue, 06 Jan 2026 09:20:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcVKhmSOxrYJdgdUdXOibewTJ5CLkfjpvth8cSPNn9My88somjEwg0WSoJvtWbiqCzlMfSjQ==
X-Received: by 2002:a05:622a:13cd:b0:4f1:bd73:ac6f with SMTP id d75a77b69052e-4ffa7833eb3mr49446151cf.74.1767720003816;
        Tue, 06 Jan 2026 09:20:03 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27cc6bsm274657966b.23.2026.01.06.09.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 09:20:03 -0800 (PST)
Message-ID: <ad67d007-7e03-4ed1-a163-9c16aee791be@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 18:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
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
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater>
 <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>
 <aUSJJtRNOJTohjCS@bywater>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aUSJJtRNOJTohjCS@bywater>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V9FwEOni c=1 sm=1 tr=0 ts=695d4445 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=SXg1PQ7gjAQXpXJ5tqcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 2YCXtwcIgZpJWekbFErfD_cB5MIvfO1l
X-Proofpoint-GUID: 2YCXtwcIgZpJWekbFErfD_cB5MIvfO1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE1MCBTYWx0ZWRfX5tIiFs3gwhcq
 NpHd3VdznQpgjAhMR++o0401wd8rX2WV7MRXofKIGMsx/Eojd3I5N6pzsKvdrM6tp7c9MXt3WGA
 qnFGnPaThDc/UwWkBsoqp5Py5H6NweocsXVxgvP/X8o09iXFarIfhDXYRrvliYsDRS4kUfIrbxD
 cKYTrhsrhpScHkOGYkZFALDmIVnTWM8sN55JKP7PNGR86fwA8x0DPMLEkuAQHMTh2AFovwWrs7q
 SRX8CAECO3RWS55lTAVD56K0yyMqu/5fhjc1O26zJ1ZuMdfvdUm91J32u6enpZcOKylZii7jwQE
 eXSPSCUvoyYbWEW2HU7QHrJTW8e7FkYz2FSCSFoo1QmWCWqUXy27tUrdPuT+TCLSLS9Cq5XQT6N
 JbTy3RaxQOivhvaEGprJz3tqkrdE++9lr6KxyYHuHgY9dEy/jpfSDo+gOSYXepLKxgPOPycRDJY
 Xm8swL8DYsz/Zqaxcqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060150


>>>>> Most of the existing drivers enable the napi(s) during the open() phase,
>>>>> IIUC to avoid scheduling napi operations for devices that might never
>>>>> get used. But here maybe there is a specific reason to do it this way?
>>>>>
>>>>
>>>> I do not have idea. I moved to open() and something stopped to work. I
>>>> am investigating it.
>>>>
>>>
>>> On a second thought, it may be wiser to have the napis enabled on probe,
>>> to drop the incoming messages even when the interface is brought down.
>>
>> It's a while since then but I wanted to drop messages not having lurking a 3 hours old cooling water temperature in some virtio message buffer being misinterpreted as an actual value. May have the disadvantage to cause load when the driver is not open-ed. But I see you also thought about 3 hours old outdated values now which may cause trouble.
>>
> 
> I am stil thinking about this. We are sending a ctrl message with
> VIRTIO_CAN_SET_CTRL_MODE_STOP, so new frames shouldn't be arriving while
> the interface is stopped (i.e., once it is brought down). May it be
> sufficient to consume and re-queue all pending vring elements as part of
> virtio_can_stop()?

The NAPI operations are only scheduled by interrupt functions virtio_can_tx_intr() and virtio_can_rx_intr(). When STOPPED, and this is the initial state, there will no TX messages and a well behaving virtio CAN device does also not send RX messages. So no interrupts and no additional load by scheduling NAPI when not STARTED. Having napi_enable() in virtio_can_probe() we conveniently get rid of messages received in a race when transitioning from STARTED to STOPPED and than there should be silence. A misbehaving device may cause RX load in STOPPED but this was a device issue. Under normal circumstances no resources (especially CPU) is wasted.

But to "consume" all queue and re-queue is a bad idea. After made avail the element belongs to the device until the device gives it back to the driver by marking it as used (e.g. putting it into the used queue). It is not possible to steal queue elements from the device during live state. So this "consume" and "re-queue" is something I do not see as being feasible.

Saw in the meantime that a new driver (V7) was sent and was happy not to see some queue stunts just to move napi_enable() around for no really good reason at all.


