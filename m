Return-Path: <linux-can+bounces-6007-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC92CF9782
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 17:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DF7C307EA0F
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3430FF30;
	Tue,  6 Jan 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Erbn7mW7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvtMSeMw"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4B31D757
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718236; cv=none; b=BezOMFVtd7uARfrXcMIz7YEpcHBQUp/h8BiBPQMX++a5spWJk2ZuY/I7dYKaoGTmf9BC1Wteqg96Nbi8qY298cQXMgfOsfYxWHQglqcfwk5s5tjtCInWsz/VDIMkc0BgK5jRDkk6KNkYlAoTghcQgMUGVpDMeH5ghft3MA59wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718236; c=relaxed/simple;
	bh=6iSHSTGCHOn+oNl65sjP1ZpMqEAVFdqznf3RZmtfug0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntr4MWcSbBhUBLZiDpEYaDzyZaT6pMiFR5bIEuJ1Y7s7cuWA0oJ4BZaIKDYy4y/d4s+uElfPl2k93tJ5+Xp6kZq6ipBLeGG8WdOm0BlUC/uP8gpKMdRXWg8qst1LEjDwoD5aRcwcazlV75z6sk1Dq7v/mMSb/PfnUmttZd871+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Erbn7mW7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvtMSeMw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606Ar8EG2255371
	for <linux-can@vger.kernel.org>; Tue, 6 Jan 2026 16:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VAUtlmRjLy97NcqtQuTcG7bRDJ8Ja6OXdIIzOPTCSs=; b=Erbn7mW7FGK8CHMe
	HevbAcgZu9/+p+jdKpzsXslBskXkFudpJPBk08oyb2pwkqq3m7TpWbxw4WdKy5OU
	sZ/OM4NUfMAnlCBH3oKa471Cw9k8rV/a/pZdICng9c0iDCJ231Rv75KkFhY4GVn7
	zcDgr2SlrBJ53QtC4yXYe8L7a7m6UU/6t5BBqDGW1D4SiltxbBIxoECWsMMj4PIs
	BUfH54yq/MoR5x5rrPPz/qQ0C84mwcPoBDwQEiwp+U0dxUQzBAc0/exOkFaxAhzD
	m+ARe0ZXnI8G+ksQk9kjrUzeVZBtFVfznuMDyzX8u9LphhYvz0i1Pajn12hXPr6i
	m47XKA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu422542-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 16:50:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ffb28462fbso2222071cf.3
        for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767718233; x=1768323033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VAUtlmRjLy97NcqtQuTcG7bRDJ8Ja6OXdIIzOPTCSs=;
        b=cvtMSeMw6+eJKrmp8aMrdkTTmfWp76AYDgjtK4ymzPoWfDZvcL35mjvCV5FZl2pRI6
         s4oxPtgRrTVPxaiu/kseKwzyPAEXfStpOkaGJj5fkPbQyZFJdVji2ULHTzHyhkabUoD+
         z+82Zb6sbPC6XSM4yQ5OKu+NM+FwuOtwj/wuMbupa/n3IdtBty9WGHOlEtUgh8uMm+Pv
         eFHasIgpZiV8c7uhXsOH2fgSqW3e/x8kCm16xo3tcm29Tgaia4FOEFFpCacUj1s95GQK
         CbzGW97RhVFvkUJsa7ADyutZxIw7r0Zn4y2dm/5uHmDy0kB3jmN3jHWTn85v/Vsm7vOP
         Kd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767718233; x=1768323033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VAUtlmRjLy97NcqtQuTcG7bRDJ8Ja6OXdIIzOPTCSs=;
        b=D+qNAKGkmaah75gM/sRz6lcRK1cCfGgU6VyRozFjqh+6xiJqOc54fiZbcRp5FK7vKf
         /CzoAFlef/dOKRF1FxqqYTUZ0a7S1r9nvXS1Qrxr3PFB1YGPjgrRKg2Ipw1xXbg/G+Jy
         jwA677ZGXCy97ev6thJTOB5BwOoxXsN9wHaBJ/XCc1W08U3qQDSKoAI9EV3QJOB4PH35
         lDQAdOSwY/Qnfs367mkIQkbSzaqoa5p+esFXnHE635lbV5GW39GiO9iGAYT413kHIZ9n
         bJrrSyneHdGou5GcO+0o/nw8Ql99rBhJ9otMHowaREADleYja3rRQe3rDVehjHpMpjqc
         5YBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd7bU4F23JF2Y/kVVFLvKhjGhxK3QesGjqJ6x5x/u9+3WyJR22UngOhKlwOHCQiw+1y3IHPILSFJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzInSlXkoWbfnKjILJJtjWRBd9gD0jDGTc8huq7dCnlTuag8dPg
	MxHbo/kNlfxXAaSiuPWU3YdEimokV8lVu+I0O/Hr3czxpdIvJNnw7FxrYzop6zNbTagoTxU4oQ3
	/TFAqBBY2Sdgn3mPT7Veglo2iP5A3buHshsajXT5lmi3YaEkQECTMG3h1eTd20yU=
X-Gm-Gg: AY/fxX6bcZlmSB/ISEBiKWY8S9GaxXreebeYpAQgYiOSXWWIO9jmdL2wDM6PLbJ8L6a
	BYUXicR5SwykrzIzV36r5Y6LS3XUmAhXYkNT9doifpE+zop4tnFNxT142wXtzNeN8+FPYf9TlBP
	qdGSahg2OYL+7k16va1xcfcjwazUtESNUmJlmtbSbvek0LYkrsDtppYDhsjzfk7CUyPrTrhs9wm
	NjNK90fd+/uW74+5VydlCCJQd5erG9bf/jLtfPiqzcbxoqzG66gBh+Zzj0EGkaI6l/jSwZy7KQo
	TImhdtXkghWjlhjTz7623ZWbz2m1X3xcMX0DY1y/8MLQ+aMkxzTBPLbnD0q719fPSezSRV5t8aW
	scnO03EaSzG9y57lR1HigY40=
X-Received: by 2002:a05:622a:4d8b:b0:4ed:e337:2e68 with SMTP id d75a77b69052e-4ffa781aef8mr44277291cf.81.1767718232843;
        Tue, 06 Jan 2026 08:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/ZXbhNy7Jd7LAhxEa8VoxNP3Jg/EJKMvwej6K1JBI+OtThxBa96D1dk7k6OgAcGm/ULfcxQ==
X-Received: by 2002:a05:622a:4d8b:b0:4ed:e337:2e68 with SMTP id d75a77b69052e-4ffa781aef8mr44277011cf.81.1767718232444;
        Tue, 06 Jan 2026 08:50:32 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a563f0esm271661566b.60.2026.01.06.08.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 08:50:31 -0800 (PST)
Message-ID: <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 17:50:30 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
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
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora> <aVLq1ibPcPHk-7Qv@bywater>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aVLq1ibPcPHk-7Qv@bywater>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695d3d59 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u_aeR0i784IBtNsgb4sA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: o9FIMMEv0SsUzPrFxS8lndggwe-mFtmd
X-Proofpoint-ORIG-GUID: o9FIMMEv0SsUzPrFxS8lndggwe-mFtmd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfX0YBK1Qjifk7x
 kvrhEWNvvUKNWIq3/ZBQ7fC3Kq5yMC4ZKPbC6RMI98/EaXFCJv1b6utcnHW9OCvfqZx0W+lJKsj
 jAfAnSsH1YqGDX1wAr+q7uEhpcdefakYZEngUIIqYP+8Kpm6V7tGMQfO2rk+IBtt07LvTQMMCu1
 g9CMp+Jr6twPqc3dMfEJt72eOrQXGiwaT+kuXeCawnNzDqGdTPgqJuK/94imDeNWc11Nu42p5AX
 Bd4ejmBMmR4yg34uL9zAHMQnYEPpFnLvB2EHYVUm0+EP+X3Nz8OymIHSyRt0DYuqzdT1lHwiCmt
 dolKB3aGLFvbtwL7W1CvAWOWn1JsUrVmjaTC+gO2lv4q/WNvEpWT8qhh1CIwTrduWx+2r7rW2JN
 GZQzXbAcKk4GB2HvVj/0iR8K2EC3EhFOZ9AwyLkL5Lg+bhPkmW8Z9ofM3w7KMvz5Wf7Y2q5cCFh
 ZB/PJ8LKbA4QZsZIyfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060146

> With the plain 'cangen' you are not really flooding the interface, since
> you are only sending a random CAN frame every 200ms. The only way I can
> reproduce this behaviour in a consistent manner is running from the host:
> 
>     while true; do cansend vcan0 134#00; done
> 
> which seems to generate the maximum amount of traffic.
> 
> This is not of course a realistic bus load, but is leading the system
> (at least on my setup) to a corner case somewhere.

I have no idea how long the shell needs for a loop, always used cangen -g 0 to stress the setup which is most probably faster than the shell interpreter, and sometimes did this for both directions (RX and TX).

Full load is a realistic setup. And even if it was not, if something stopped working or worse crashes torturing the setup this was a problem.



