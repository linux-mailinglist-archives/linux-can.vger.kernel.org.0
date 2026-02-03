Return-Path: <linux-can+bounces-6465-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJpiNyTigWmDLQMAu9opvQ
	(envelope-from <linux-can+bounces-6465-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 12:55:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED25D8A98
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 12:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF804301703D
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AE433A9FE;
	Tue,  3 Feb 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpAk0F/E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PqMKd/Tm"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AC33A9CE
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119713; cv=none; b=q3jQja9Dzq0n1Lqjf6rDeBRDvwn7YBgEfokBBNHNlLcd4B/y/ppmdUj0MtV5cjR3zNj2YeMFVX7xCrwVimdDv9ID5tUXRSV5O5uejcQZ2JIzYY2eTCwLWu4MGBWdLagrKb4WWy44MaidpXTaOmFE1IMlKovr4Wks71ILB31LRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119713; c=relaxed/simple;
	bh=lOecQHF5OFB8heiN8hsmTHJySpCloKpE7IzIr70fBoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg+QXNOSeSll/5+Gzjt1DYQpgKtrbyq4ct7srA5mV1rF2BtIFWczl+BNXmNgdL/kQf6YwaBS7jzwxDWtEsoRpD8Lwr4EZmQfWaoLnGpPqZB6PXtUqnEmaSZBGsuwWMv+iPFb1DH7Pift4XHUMl/QDX8PZCiJBNT7qYX5WrfG2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpAk0F/E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PqMKd/Tm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138o1Yv849049
	for <linux-can@vger.kernel.org>; Tue, 3 Feb 2026 11:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MDuT0B7OylkoIAE5tcgNAXoUzztKFfX7/W2HioUlO8k=; b=LpAk0F/EBp5Lajim
	lhaFUI7b7iw8ZMu2CBA7SW/INIYXw2SqjreERufOq2JIQQx+PpuFL6xCiq2zZYeX
	LnzzbCZRYEG4An4ZnYmWeFb9M+55YP7HC/6GmdUF20BrV0PehwpNmkO1SpIsR2Dv
	WsEA4d1RMGlovvFPCQkyebtFYoAsST/BaRXF7MvvmdscNXLFuF/hTl+aegI9NYJx
	SrOOa9fEpYXLtafUQQOps8VEx04rbSdHZum/yGvmgNYHNOZXAHfv4ttVkknij/kk
	4FbZ6/15lah2RS6lbQbfsLxYX4NfZsecW3UlK2oWZWPBK1MiZWMB5adevXuu3J69
	DmN1Zw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3dutgjeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 11:55:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6ad709d8fso209605785a.1
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 03:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770119710; x=1770724510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDuT0B7OylkoIAE5tcgNAXoUzztKFfX7/W2HioUlO8k=;
        b=PqMKd/TmNl8zCqGaWyVrwO/dglWRS+WCPjPrizRBjX37ybye8kfWvIua6oX2mNH0Su
         U7Cff6Yx31/cGMrF/nUqT3K+hz9JVOlC4I1YnPs3/QWpSd/Q3OIhfys5TRraq0RJhJ4a
         mCJzmtpMzZ+RIB8T9ukLLfbOh5PansGX/slCZhZtzPrzseQDubQWe1liKP+PV/Fw8evS
         FEsqLyULz9mPCu/nQp8WtKoIaKDkozW64VDkVu4/E0D2xhDT0bKol4u5zpIMbFuQ5Gim
         1J1gkwJAl2T3UrtSrHJGmY/e7d9B4aydJT9Kvf2gqqOtPk3zs1yvAjBO0IM/tBvK5scP
         IVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119710; x=1770724510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDuT0B7OylkoIAE5tcgNAXoUzztKFfX7/W2HioUlO8k=;
        b=vaGkoP263pz2/iLigIsTuExJCwyViQ0rkwJ7X4OyaVSipkvK3HQ3VNAe4sYH3skiOj
         3yDUz5U8LEZf0y4dDL3ZLkSBJNb4WuWaayW3Lu2HNm2l2MvQikwVOckE654lhPk2U/gC
         qQDpc7PKL/fu/UsFvZyvZ7JgV71BOh0Bv7fOwq3DEr/eM/mFrXDJGjQJQubCkIXn63Xf
         JglOAEY0EWIfyc5Cy02fvVvBUYsVHPFvL9Zp5jsHLthaJ+liSVfU1Erv17SgcVYdSQFd
         j2ShLGqp1OYDf1lCcCeCeLkP6/cVPVTmgKPPSFivM61DL0PdMOsz56VON6fzL7MAtLE7
         Dt+w==
X-Forwarded-Encrypted: i=1; AJvYcCWoFg4FYmAd71Pv7Q/4GPQl9KiQgYxnIIBMq+wWUDvQ0w9e++5rP72Lqpxo/U85hpU2uGwLyEtWPBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDDr3vX6S7CTGF8IK28c7SPeRMFF9w+iTwogX35hGLCvGs/XT
	QXHlgJGx8wS8p5lAmVAh/xSDglqtvBrh5V1EyatIQmtQEKSChBbVXwYhk3/6l+bXfO+4DLcaAQW
	yJulp6SVOTs0TyjALRO+I9nUcOhNUhN7RQJYg8+DAIOfQJB9Somc9vJkTwtTzuks=
X-Gm-Gg: AZuq6aInA9zJ8GNY5EjL/hfpSfZruwQN3WQDJI8YMc3vJnGVnyO21sY+vJqkQRSKzQi
	DePpFXnuKodgpdgRbvYJo7KAGhXlGhm7bWH3xVNxZpvB9wYjI4v3QZZIR1lmkaQ80ewqFAAJVHo
	Wnt2+iRVAC59/lshnsLmKu8jphRpazoOciFjnNkat5r1OrQ7hr4euGgBSVMeIoXav3xBS4VLaNG
	lozSEP7F+758QHqvbPl6pA6mGfpKM/h1WAT+MWz+/fkFdDF9lLj9QMPyy6mzn25toaueRZRv29X
	qg6/Zr/qRj5/rNDaQXx7V/kOECYW3UHgqgpmdK6Z/DC6EvAvf+h8adDJKQq+Y5svEFokDUFiJlm
	syfQCV8rbyJX5dx+2pN7mjl0=
X-Received: by 2002:a05:620a:f12:b0:828:faae:b444 with SMTP id af79cd13be357-8ca20483debmr282370685a.20.1770119710071;
        Tue, 03 Feb 2026 03:55:10 -0800 (PST)
X-Received: by 2002:a05:620a:f12:b0:828:faae:b444 with SMTP id af79cd13be357-8ca20483debmr282369385a.20.1770119709628;
        Tue, 03 Feb 2026 03:55:09 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd4a5b8sm143604075e9.5.2026.02.03.03.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:55:09 -0800 (PST)
Message-ID: <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 12:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>,
        Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol@kernel.org>,
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
References: <aVwGfOlvRqdv5xj7@fedora> <aWE5duyvXCuwsMAn@bywater>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aWE5duyvXCuwsMAn@bywater>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NCBTYWx0ZWRfX8zKgBLYFCMXE
 Wi2n7fKUUYXJ9PBykJrDOyqfKlRTnFVDbsYDc+cCltCIWvSGh7jYmLDH0sTiIkGx18awLDXdt4j
 3eBe9636sChb6nvm5h2uTcF9gCGoTUHvIG7aqY95YieqKHz5VIOn40TEX+nU8yytmpQE4peR0aB
 9rHU88fDusFxSXVcOGwm8cCNDpFYZkqiDrjg1b8gy6BsWwSNVkGvtzMUZmtsxPH4AyYMXi1MlUJ
 MphHrDF0BJwTt7790ZOb0XJ7QKYdo/kFJehHlD5DWGZQy3RqBpD2ziE5UzIwjq7WVb2gkngxUm4
 PYIdsXZJ4lRHih6M1e0QrbkazxT3GZhpDxAvECWyQRjEEd2JGHKmdxxC5XZvD9QQSbCzPWAnhlg
 1Z3+wWsPk4XCfR2K/blFtbNe/IQXE5Mq0nDzc1b9XhQZlicP/Q9mveS2FP8/tyIZNSJHCaZb0Xw
 qCRqht27fTLHrVChJBA==
X-Authority-Analysis: v=2.4 cv=FrgIPmrq c=1 sm=1 tr=0 ts=6981e21e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Am9B1zxb3eBZUTWmzOgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: jHTBKQtv-FL_6kirPXXub6oQFzueZIf_
X-Proofpoint-GUID: jHTBKQtv-FL_6kirPXXub6oQFzueZIf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030094
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
	TAGGED_FROM(0.00)[bounces-6465-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 3ED25D8A98
X-Rspamd-Action: no action



On 1/9/26 18:23, Francesco Valla wrote:
>> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
>> +{
>> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
>> +	struct virtio_can_priv *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->vdev->dev;
>> +	struct virtqueue *vq;
>> +	unsigned int len;
>> +	int err;
>> +
>> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> Nit: consider initializing this above, while declaring it.

All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.

The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.

To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.

Solution was: What you see above.

Regards
Harald


