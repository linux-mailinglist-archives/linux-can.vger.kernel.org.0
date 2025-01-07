Return-Path: <linux-can+bounces-2557-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C505A04805
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 18:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AE3A1008
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ECC1F4E30;
	Tue,  7 Jan 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="WHs3cRTq"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106D1F63C5;
	Tue,  7 Jan 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270244; cv=none; b=G0/j1kyEljIa1t8XRoTWZAnFG/8UTJFV5K1Spd07rj1Skg6+cqgqROwy1Nb/RjHHOdvE575kq+Fi10tk1YyTDsqA9On0meSf+8t0FGWx/4f4S7DlhfeFkGBjQez11dzGMsk3cxU5OJfEdjB3oH5BEv6HOl4aZ+wevjSll7E0HwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270244; c=relaxed/simple;
	bh=3NQFy8xnlv0whKeRQI7gR4i5GEVkkruiwHonrg2ArW8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WHW2eRZQcsAC3TPc9m7wjuyPdhWZOXsCP2trWNHn80oVNo2yVxhF5zEE8PK/i47dzHKpuRn8UycePwJQnk54MDaaHctypIhscBUoELuB4pyx2dm6KUpeSHVXJdkPrFsfdxorO8LwIj39dac8l36Wq2cRSa8YxD9Df5C95Jc/HOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=WHs3cRTq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736270235; x=1736875035;
	i=alexander.hoelzl@gmx.net;
	bh=KeTpUbEJiVNxhKwHVLzHeSrqf/eIGBCdfpQfxHPMZRQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WHs3cRTqkRt8iKwpJqMV3khg8xL1iRzH30NLnqUWjzbf2RCrqcv3FIggV9Oha4Lj
	 0nQgObU6jqmYpp25RQoNqO5Dl8ax2++sotKCctIVNurtEicOt1uwH1wGKA8SNi3kV
	 OYr4WqUsUNnszK0GBOWpH4LjO20da5aLmxzJkTCyz5JiRxy4nuDfHn6uxg/hcQJS0
	 j+6HlgKkehcuvpJKkuyCexTPp+wh+s/PU5WEgarRrBzWIWlNcdsY2xmwwBBPMu6ve
	 iZgEx+ABBx2WSpII20OgqgOtgfi++5y8U1XbIjuwGoAnrVUI2jOM7UMv508RQAvV+
	 c0JxTL1SHCoTB5HMeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.199.73] ([213.30.210.169]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1tpxV821eH-00mXoD; Tue, 07
 Jan 2025 18:17:15 +0100
Message-ID: <8412e625-6033-4ea2-84f1-209c82ae5866@gmx.net>
Date: Tue, 7 Jan 2025 18:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: Re: [PATCH] j1939: fix unable to send messages with data length zero
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: robin@protonic.nl, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250107133217.119646-1-alexander.hoelzl@gmx.net>
 <20250107-conscious-daring-lemming-c63aa8-mkl@pengutronix.de>
Content-Language: en-US
In-Reply-To: <20250107-conscious-daring-lemming-c63aa8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1pCOt5LyfEXtJoR/8nFMa26b0cVLPpYOTVkCWIJd/nUgPticrTc
 tqQToICXwOov9soZ6a+4a9jFtlkE8OTewRQqT3AYd0tQjn/s3HFKO+eZsMBfIOzs0djk4VO
 vC1uZLiVg6/Gtv84flOX1KDsN7FP+wbThm/o6nlwgv7Rn1hhBG0WuFxC5/tWZO7wyuRKovP
 gHnJW/5codVLgSvTry1CQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lJ4rkFJ+hkk=;dybV5MtnaoUqMr/N/yysRkWtIQ2
 OCphvITTYVIGijMjYaOso1Il/BL83904/4zgs46+yTRapZenKiUey8xsoy0gyXzXgqVP3yPED
 CiKE/F1Fxtbj+1RxWXc17Ad/Oy3z54+Moj43qCsXcHzkyqNvwzcodVIUYZPaVr0sYyH+lnr3J
 1ONfQ5OEo1u4x5MLU0XWdayYB05sDt+v+agbAp9dclFiKhkfEGmfLMEOWppsxYw9NlEw3eCdd
 hu2nJoScyLoI5BuIulprgTbHEz6UdjBERrN3l1U6ucJhf5guAnBFg2dQNwXAmDMBWlP59qf0C
 wq3De08gMv/s3Qht4kRTNUK3RucsYD43U1Ooi2OZetAUKF4nFS8oe0SjbN2yRptQQ72LQg8Ab
 T3hF/IjMeUYhTeDrL2M5RaxNVhPz/3bVSuvIWldHegEunmGNldqGskTWNhik/wRrIT0XAN3Jr
 01DP5tdNo7izyhz4k4CITJ/bLIZsibK3VDhIGLpvFPLU6/Ar0xSJYae3gg+JzYycnfKQIjQOd
 Rs3B0sKc881kKTqymW7/FNhAHcTtmEstcwPGMTWjWdiJeNO575EbPdiP8LYM4E2Oflm8KAGA9
 G0vjP2l/XkRTwyjDxUdIMKxX9WYknLInYP/skPp8plmytWItzH9Qj1FonDT+Ujkk4EqBuP3jg
 qO6Gof92Hg2AjEj+uT2hWmf4ckiGGoJ2ktdzir1qp+TrwTCbMHBiz7kH1mOu+BahkSwxq3FvW
 PAE5QTn+R8SttvUTSNManH9os4DkrRbK2sBBf/L6HEZyu/2j1wolDs87dmKWAibPYA0XnNvVv
 yIEZhVdMJ6sKgmRjBAYLwM/oYbQCPUTTPohOCBQxs/UTiDgBcX+3et/5UlcP721WUTjn4ocxh
 uZV+9+TecT7mmo4l12hdDnKlNmDMNskVS1NnXMaME+4MbH1R0tGCZWe0JOiWM/1LBerrIwdxS
 9iFoQd2tlJgYNPMGPfcxr7LQFvXprFCVBdfE5unwBu0ar8bRbwHYDD2u+6hin88TWhACguj3C
 6z1wHK02H7+i0ok+F9TGWhw6+R43iMwna0Gq7TAKgwsGoH4w8LyWxbTA/3lAO20H8vmeG8tfG
 Se7BkwLOKU4oNCOXhdM/wkLM/jrLfE

On 1/7/25 14:48, Marc Kleine-Budde wrote:
> On 07.01.2025 14:32:17, Alexander H=C3=B6lzl wrote:
>> The J1939 standard requires the transmission of messages of length 0.
>> For example the proprietary messages are specified with a data length
>> of 0 to 1785. The transmission of such messages was not possible.
>> Sending such a message resulted in no error being returned but no
>> corresponding can frame being generated.
>
> What does your patch do? Please describe it here.
>
> Marc
The patch enables the transmission of zero length J1939 messages.
In order to facilitate this two changes were necessary.

First when the transmission of a new message is requested from userspace
the message is segmented in j1939_sk_send_loop. The segmentation did
account for zero length messages and terminated immediately without
queuing the corresponding skb.

Second when selecting the next skb in j1939_session_skb_get_by_offset to
transmit for a session, it was not checked that there now might be a
zero length skb in the queue.

Also as this is my first real patch I'm submitting please don't hesitate
to tell me if I'm doing something wrong.
>
>> Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
>> ---
>>   net/can/j1939/socket.c    | 4 ++--
>>   net/can/j1939/transport.c | 5 +++--
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
>> index 305dd72c844c..17226b2341d0 100644
>> --- a/net/can/j1939/socket.c
>> +++ b/net/can/j1939/socket.c
>> @@ -1132,7 +1132,7 @@ static int j1939_sk_send_loop(struct j1939_priv *=
priv,  struct sock *sk,
>>
>>   	todo_size =3D size;
>>
>> -	while (todo_size) {
>> +	do {
>>   		struct j1939_sk_buff_cb *skcb;
>>
>>   		segment_size =3D min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
>> @@ -1177,7 +1177,7 @@ static int j1939_sk_send_loop(struct j1939_priv *=
priv,  struct sock *sk,
>>
>>   		todo_size -=3D segment_size;
>>   		session->total_queued_size +=3D segment_size;
>> -	}
>> +	} while (todo_size);
>>
>>   	switch (ret) {
>>   	case 0: /* OK */
>> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
>> index 319f47df3330..99832e60c08d 100644
>> --- a/net/can/j1939/transport.c
>> +++ b/net/can/j1939/transport.c
>> @@ -382,8 +382,9 @@ sk_buff *j1939_session_skb_get_by_offset(struct j19=
39_session *session,
>>   	skb_queue_walk(&session->skb_queue, do_skb) {
>>   		do_skcb =3D j1939_skb_to_cb(do_skb);
>>
>> -		if (offset_start >=3D do_skcb->offset &&
>> -		    offset_start < (do_skcb->offset + do_skb->len)) {
>> +		if ((offset_start >=3D do_skcb->offset &&
>> +		     offset_start < (do_skcb->offset + do_skb->len)) ||
>> +			(offset_start =3D=3D 0 && do_skcb->offset =3D=3D 0 && do_skb->len =
=3D=3D 0)) {
>>   			skb =3D do_skb;
>>   		}
>>   	}
>> --
>> 2.43.0
>>
>>
>>
>


