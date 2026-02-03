Return-Path: <linux-can+bounces-6479-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFZFCR4SgmkgPAMAu9opvQ
	(envelope-from <linux-can+bounces-6479-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:19:58 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74573DB340
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E14303FADF
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F63B531B;
	Tue,  3 Feb 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ApWdl6w7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcFcBLyD"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90022FE59B
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131895; cv=none; b=k/oI4k8Yu9e7qBs7REPnEi76KMfGpipAWY/bbjhd65fshg6ynwAqKSfED5ctaxYHYo3ojeubYWZzWh5llbHGddQGi26+0uzvzlrn9aZnVAJOTPkcoapFlBy+gkRgu1DxiRMkXJ1DOvgrZVtwAxU2enNLNpYqiGX/xvqSAXtpPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131895; c=relaxed/simple;
	bh=huBTCAC0SSikbAdwLz43/1SAs20PtE+f0ox3U9SYL4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhl/rkAwY6zMM+LDZSMElY5hEGzVVDROdlihmJifzClR/2StowHYLZChtLhtF18JYdrZhkGbG3tmngBwPjUNhSbtRiGGNDQoHAB7RKjPQ0utpef1xBzHm/FmQ0SmVDMLrnoB6Fe5Adt8QGDSwvwBCUJFeWXpBJxBCggcPg08QMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ApWdl6w7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcFcBLyD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613F4r8C3631836
	for <linux-can@vger.kernel.org>; Tue, 3 Feb 2026 15:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XH5EuiNvejIxGNn5Hrr461F6cF6oIwOIg4suguNnfHg=; b=ApWdl6w7gYoO3z8v
	eMidIeotZYkoy3pUA0QLRed7yVoFp7/y54Y8Y7ZUDY8w2VGTM+tcmiyKp4M3ngtD
	MnAWKWj2nzH73b/sPy2m4h+gwE8vxR2E/X/Q9zdZ3WOnY9RZSu7oBxq72mYtFc7C
	YSxfBo+WiwIX/2bktZBXMvQUbn8y2BtgZhCfWJkQpQLELNseeB2ZkApauDZBUVKB
	eAqMnw4uf2FyB4eCUHLnZ7+xa+pzftEIjnUKYsEUJAAq8r1EoAnNKHZ6j+a+Q7Lc
	bw4ARNo62UG8j6NmVYNVry3GXYPS+yBLizZEc6DYB70uaYal3sTE9m4yGfZLI94a
	eNPBZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3kbkg1er-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 15:18:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70fadd9a3so2071759485a.0
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770131892; x=1770736692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XH5EuiNvejIxGNn5Hrr461F6cF6oIwOIg4suguNnfHg=;
        b=dcFcBLyDH2cuk+uwsC5ueyGzcHGs43uiHvnoOmOdG6ylOOiix97BxOrvjZdGTAYMv7
         v0Z5d65dr1LPmCKV2BJphMtdjQV+U9nRQiZ3YhGDZShBC58AeheQL4jDxC7OhMc3luEH
         YltQH9HS7er6ES9ZXeEKk41rLm8SKRY2VrxEeu8JR2G+bbBMd5/mIq3ysqp1H7Jmyh8O
         9ZrjJZ57kcWIAvy1ltCklC+/l1KxmtKHNbrsAQiH9SSXVKuUj7BQdTnbK6pJl2kn2ucY
         /a7pmUk+sQFV6WGYJgUNGhNnAW+TufkvKAGAJrPBGEy/cuQUWDG9Dh9bsR8UmEarOP2R
         v/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131892; x=1770736692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH5EuiNvejIxGNn5Hrr461F6cF6oIwOIg4suguNnfHg=;
        b=lCWWUq7eRm5etJsnX+A0z69YbuxuJ3wRedRVUqSQ3YPNwqR9g05ScwrdzAb1XBIgDP
         xwPDj945kBLftoQeot/DlnDvHulemC7wodYPuVNOWLM2pgRmJjHwWQlu8SYuNhAdrAqs
         OZBQOC4l/oM3ejs8A6kve0QJVjVQ5Ia6rsf76fxaoTl+Kxx1Zyvt27Os95NBqGx4fo10
         gVgVOVOuqD4emW/B4QZZ4bET+fGRLJkyJ1w1tcR1Q/Ci4a8ix3vgKSoGJW0RqreigzLf
         meWflv1kkVUbTEsSdPpKuBZ06ac+wt6dj4pXpGQSLN7SjcTCoTsSdjOxUDlEFvWY8twK
         2t+A==
X-Forwarded-Encrypted: i=1; AJvYcCUIYph0qMCF4GZ3rgJCNiIxgx598lF2YxHaVtae8WehRyyZUu6XhgEriHgTETG+jn19MtPQLjyOaDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcWZbsksLGsmBg9qPiQinPpk50lEZvOkBW+13Spum5n+h9ge6
	DCxcYc4TjsenkPTuk/mC40kBTRGMaqQPRa0mUE/Q9afPm1fCeQzEMH/C5FU5HzT7T6f6znxtIbO
	H660YuDsh6S+Hf4+3oNjqRV/m8XXfwqxQuO4HDsST7YWRvzVErrSgrlNnRCWILmKD+0MBsqc=
X-Gm-Gg: AZuq6aLZHUo62ukGhZFMMHSFD7KdTm/uufJZZl9hT6CgRIFmC6cmB/cYcDLT9b6gl17
	QxyzXZtytRQ43JyIPN/rp9cfjwHWUG3ZQz/vTw23K6/7dUFHlaGV+iWG3NUAldc29wFfuoU3chr
	SoBa2BaJoX6OvqDO4H6IV6immAMylLzOt8AwrkLOPpvnjwca9vV+xoIKzfqLviZoCNhvdGDN0Zd
	TLoR3v/+adlTbxmil71G2GMQai/p5YC/N5e8K94omqoI5N8uHQEk+l+e0Qa+RDPRDZSzklD+444
	dwB1iD2a54okU77eXYdGBQIWlasvvFcfP+sw3IJEDw8+HNrLySNus2ixHuP7kTTw76JnZJyCFW3
	F5ZjHWAR02wiiIwTSryhf2kg=
X-Received: by 2002:a05:620a:20d0:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8c9fb69e75bmr1174802185a.25.1770131891643;
        Tue, 03 Feb 2026 07:18:11 -0800 (PST)
X-Received: by 2002:a05:620a:20d0:b0:8c9:fb69:e708 with SMTP id af79cd13be357-8c9fb69e75bmr1174797785a.25.1770131891179;
        Tue, 03 Feb 2026 07:18:11 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm50385318f8f.17.2026.02.03.07.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 07:18:10 -0800 (PST)
Message-ID: <5d9645ea-41b8-4904-abbf-3b201183e2fc@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 16:18:09 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
 <mailhol@kernel.org>,
        Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
        virtualization@lists.linux.dev,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <aVwGfOlvRqdv5xj7@fedora> <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
 <20260203070338-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <20260203070338-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MekiBFdT-6COezGtCNsZ9ZeyC6NQAYgU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyMiBTYWx0ZWRfXzNmdBKN4tYmC
 1hSri7nNMr8OvlOpl/wdPy8S2enbkCY/bFL20M0i1bpft8mwi/8TijqDJ1dGiaUZoEXKaIrlvtT
 RXS0upwW9uXti44shW6nEaWzjoaohqstZ3URmvIN3m6+8XgxVVYRCCZKraxYlL4DDdxBUqOJ/Ip
 +Ubzj3Ga+UvpiFkxRJDoNOr9zD9M6sQJ6UAHLvkDj3B3cpcE+B/5dODF9UcOdC3yNKxditUgMTR
 joc5sXpuB2yTOBb/IYQ6//UW1WFLnDTtWajkjT7GXc14nll4Z2OmEvgs5DNiy32tfGuRQBslvpC
 N75DYILeHOqsHJCYtknLCuZRZvgeEkl1Zv9mQbBvmmpgJ5n5svj65mAl4k/QLlRICrGl180k+dK
 Fm00+NuswFfTy3eF18Par6HQ0qkF88QYO6Uju3THUTPfd3SSoEbd6aT5RkcrB1qhvFp2RZGXIDf
 NS3oERom0h9USan+qaw==
X-Authority-Analysis: v=2.4 cv=BKy+bVQG c=1 sm=1 tr=0 ts=698211b5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JgmFLj68GAqNGjo_vmsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: MekiBFdT-6COezGtCNsZ9ZeyC6NQAYgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-6479-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harald.mommer@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74573DB340
X-Rspamd-Action: no action



On 2/3/26 13:05, Michael S. Tsirkin wrote:
> On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
>>
>>
>> On 1/9/26 18:23, Francesco Valla wrote:
>>>> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
>>>> +{
>>>> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
>>>> +	struct virtio_can_priv *priv = netdev_priv(ndev);
>>>> +	struct device *dev = &priv->vdev->dev;
>>>> +	struct virtqueue *vq;
>>>> +	unsigned int len;
>>>> +	int err;
>>>> +
>>>> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
>>> Nit: consider initializing this above, while declaring it.
>>
>> All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
>>
>> The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
>>
>> To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
>>
>> Solution was: What you see above.
>>
>> Regards
>> Harald
> 
> So you reorder it then:
> 
> 	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> 	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL]; // priv not initialized, will be done too late in the next line
> 	struct virtio_can_priv *priv = netdev_priv(ndev); // you see it?
> 	struct device *dev = &priv->vdev->dev;
> 	unsigned int len;
> 	int err;
> 
> 
> and where is the problem?

The problem is that you use priv here to initialize vq in the line before priv is initialized.

> 
> On the flip size, this guarantees we will not forget to initialize.

Static analysis is your friend.


