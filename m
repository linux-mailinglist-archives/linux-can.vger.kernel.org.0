Return-Path: <linux-can+bounces-5882-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C22CCD70A
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13C5D301A1AB
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C3221FBA;
	Thu, 18 Dec 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3X8C4rM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aHGQ3vXJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC41E32D3
	for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087507; cv=none; b=QKHOX0xcGItduE0m9+LLyjJ6r0kuGuVcykZqjIVa/coH0Em2H/9RSyx7u/O7oyqGGtnTeOZeYeN8v6hiO5PzEonO39OI/u1zeLa1y+RcR9s3MQ/aQLEXB+86dqkpH+CWl4Xxm27KWQBhG6edtmNvATvHT4eOzK3vP3KoC5poTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087507; c=relaxed/simple;
	bh=L7X+0GSgLj82VUb1AuFvOmJmktsu091mn+Obf+d6K+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCGb3WNQrJ5e3NgrQc9BpGHn61KUiwwK11RMD80lNuwJtImhH3G+DDknuO/E46ierrQ2Fl7siNsk9bwrtCBU517SA+zu2tKZ15NENCNioDMBUoUJMaXnFgGUgcRShOS9xy921E0Akbtiv9dvyIFcftPOFo2ypTb5eZ3yx5STepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3X8C4rM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aHGQ3vXJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJk35G2888676
	for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 19:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HFJcrQ/T7b3U+ffA6RMS231nfsOn2aRB8nU9edU1lA=; b=J3X8C4rM9Hf9tiUT
	Pv8PP6IQuqvyMlqT84WTIGDcOacqQ/lN3UEgu3UjkmfnopJ3HRa6CXox2jMk9aUW
	IADHmYBbdc9z1WH7SWgfuUBi/olXQg2XTv99+kDQhyicbHs1Mu14U5OBPWFubo7T
	cuWZY2q47pNRu0qMbXrTLMq3j2pRCGraKA+dHWndtwl50e2D40al4fFF9bIReAOa
	k5tE/6ojvWf6fV9a7Pd8APCi+wdWj2+xGxkdsJojxLGpU0KB3/eDAOAEj84LKVAI
	TGbzBoBE2Mx2TC8ojNFH4xGsOemiKsTqYK6pxftPI2b5LOygTiZX106uS6f2ht3i
	D/1t+g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2d80nk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 19:51:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1f42515ffso22429441cf.0
        for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 11:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766087504; x=1766692304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HFJcrQ/T7b3U+ffA6RMS231nfsOn2aRB8nU9edU1lA=;
        b=aHGQ3vXJuw+c1pbHFhoN2Or2IveDUuSNkaniyPtycuN+QDzYKP5gfe/urrlD87Jw5u
         HsIHKtWcfaOe1nCJfBG6zUr/uOHrru2RQaRSoNce3GKeRN9RkZSoWyuEWeHSld4UWXIq
         xVwuHlriBRtJDmlR84rL5y2qVGqTHVcSIpCKj6TdtkFinrK54NUrMK/A6BEQPp3vq1pX
         85dGAwa0dMNefEQb2sa3Dd9gvfPB0inMsA31njub1AeZiRD0+1lI3pPyPOomyLzOjRAq
         5CU75XWnDcqiwkPmoKoN0AReKsMQKhol6Q2EqhsaqauhKKoKvxfKpY1dYd/3DgEYoEH5
         3mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766087504; x=1766692304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HFJcrQ/T7b3U+ffA6RMS231nfsOn2aRB8nU9edU1lA=;
        b=pb3gWEwSXiwh7Ug6QF9sTLakmTIdY+Qrz2ExdNAc+POc32x4JfXFRfT/+Fe7QJ0fzZ
         zYsq/hOibB8R7ULxOYVxoePuNYMlRzDgQ71F0LXr8cg1uxXaJ1ect/NNaxvfL6EkMHql
         npxTbtFZJ/Kz6zJnJCbhySRlpuHDlY4pV+ld5qkZ+TUAfUO1hGnO+3ojs6vWD7ch6hzy
         rGi1olx3lTzeikZk3uK8RmVJ98T5CrX8JRyKIGQ84xYCU/ljPAV3A8pis1rRp3rhF826
         V+HjgkFxKgr+wXzDgb0YGtUJJnRhPXrvfZlaLGd/hbv3ioFm+7hrjudKGLP6b0Km3HoL
         2hfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7aoaDXfh9FtyhgnCedDD1bLDG8ySOHFivP5UflyegfeLTNyz6lhvlSo2iKX/cuPzrYVyc3ZIBEXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ySrYuj9VWz34QEq4yCnGA6dzqSauI4+BMkLs94JiBMQ/kOTf
	4EgHZ/gqEdAqCpg5Ua3qZJKU60Cagfzr03yJTjyXEwa+HYykXu2rpEBd6yM50Lh+PWvKTwFejXs
	EIev8R8EhSA3VzW8Rf9UkUk6q12S/TzZVC0EO/80oggi4qIZl72bME2szVl0m0PA=
X-Gm-Gg: AY/fxX6EjnaQ6Yommo+DqgThe+HrnI7FQ9bOkQCPDRMmQO0RHuMTduAMnp6jJJq0GSU
	d7au7wFO81f1lvuL1I/sWq6QDqLoZe1vFR0ueXKIOsZOfQjCf/rMLgCFq6wLuS10N/queOR24kN
	O9IIJDAU0EoAYReOMHYfDdkQzkNVd8DctXz/ANRHnzTHMwI97/nmMlUh7wT8exS88jyEF8+nXXy
	fOKc/1DAzcqTSgQzQ05nmkNlJKh72iZ4SjxztWTVCl0UYnFP4/1UMFrkGov/5yAE8ekUH2mEfoL
	GoT8ImRN6CuEA6Vg16h4m3cm8K2IcDInCw76ZLlMJX9vPEJSlwmGNlPQmfcSqmwwkQk32OT8wdx
	oQiIkwQYfxmEZ0SZL9VuHT+I=
X-Received: by 2002:a05:622a:2b0a:b0:4f1:b714:5864 with SMTP id d75a77b69052e-4f4abbcc5cfmr7157811cf.0.1766087503823;
        Thu, 18 Dec 2025 11:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhoEHgMFImCZAmz45RYFI6OsJXVaYOG4CDJ30KmJ/RZ0Z/47D3Wco2GGr/UMYE62yuj6MjOQ==
X-Received: by 2002:a05:622a:2b0a:b0:4f1:b714:5864 with SMTP id d75a77b69052e-4f4abbcc5cfmr7157451cf.0.1766087503378;
        Thu, 18 Dec 2025 11:51:43 -0800 (PST)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f512e3sm22637666b.67.2025.12.18.11.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 11:51:42 -0800 (PST)
Message-ID: <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 20:51:41 +0100
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
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aT7XAsTWr0_yyfx_@bywater>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AcG83nXG c=1 sm=1 tr=0 ts=69445b50 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VVUhki5mfUxc9q61ZyYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDE2NSBTYWx0ZWRfX7YBm+Od/ECHP
 Ge6HSc7OSxqn0LXU5kaaZnFN2Ejh9h/S02JwIW9KKbRoBAxqsYamlgxDgTUZVAWXg6CuWnpGXd3
 maVddMuABSTXlDs4iCKDIa95X40eOjKfttbLponT/6xQVASOjkpe5uFxGnP3WOOKJv+c/du9eo8
 Fvc6Ntd0/s64ieOcIcuKJ5Vj5RbA1lxfMK6uMJTbh6AHTrjUqkI+hEc8+Z/GuYQOFoBG1SMZ13q
 gmCli/ypmJH5XnQXUNBffQwPBIKIL0VjQFNWIM2zs2EmT89n/haI/dTyBnA8v3SiEniHWiREXeu
 8Bb4K2kFTB6+7KPbJpZ8qagPHPLo8xbmpbGbgS6GaMnNb1AgouVRFodPnKpGvDlZqsd2HlDqJzy
 2TftHPFcpxM/sPhlAdH5cSDYDePfjZVibYRwj9H8jhC1pyBaTLyYn4AADgcsRdVFM1iu/f2ykHn
 cPHY57HFw0LT6Ta1dow==
X-Proofpoint-GUID: yhbG0mc5Mnm1hmQbLXOpqv9kvpE1GBjG
X-Proofpoint-ORIG-GUID: yhbG0mc5Mnm1hmQbLXOpqv9kvpE1GBjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512180165

Hello,

On 12/14/25 16:25, Francesco Valla wrote:

>>>> +/* Compare with m_can.c/m_can_echo_tx_event() */

For the question whether some comments were originally more personal notes: Yes!

This applies especially for the ones which state in which already accepted driver(s) was looked to get an idea how things may be expected to be done. Most of those comments should have served their purpose now.

>>>> +static int virtio_can_read_tx_queue(struct virtqueue *vq)
>>>> +{
>>>> +	struct virtio_can_priv *can_priv = vq->vdev->priv;
>>>> +	struct net_device *dev = can_priv->dev;
>>>> +	struct virtio_can_tx *can_tx_msg;
>>>> +	struct net_device_stats *stats;
>>>> +	unsigned long flags;
>>>> +	unsigned int len;
>>>> +	u8 result;
>>>> +
>>>> +	stats = &dev->stats;
>>>> +
>>>> +	/* Protect list and virtio queue operations */
>>>> +	spin_lock_irqsave(&can_priv->tx_lock, flags);
>>>
>>> The section below seems a pretty big one to protect behind a spin lock. 
>>>
>>
>> How can I split it? 
>>
> 
> Question here is: what needs to be protected? As far as I can tell, the
> only entity needing some kind of locking here is the queue, while both
> ida_* and tx_inflight operations are already covered (the former by
> design [1], the second because it's implemented using an atomic.
> 
> If I'm not wrong (but I might be, so please double check) this can be
> limited to:
> 
> 	/* Protect queue operations */
> 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> 
> 
> Maybe the whole locking pattern is a leftover from a previous version, 
> where a list of TX messages was kept?

1.) There is virtqueue_get_buf() => virtqueue_get_buf_ctx() and there is a comment 
" * Caller must ensure we don't call this with other virtqueue
  * operations at the same time (except where noted)."

Are we safe when at the same time in virtio_can_start_xmit() a queue operation is done in parallel?

Locking may or may not be necessary here. I cannot tell in this moment.

2.) There was once a "list_del(&can_tx_msg->list);" in the code here. 

When in virtio_can_start_xmit() at the same time a list_add_tail() or a list_del() would have been executed we had a garbled linked list.

The linked list now does not exist any more in the newer code base.

=> could be that the lock is not needed any more at all
=> could be that we have to protect only the queue operations now and this would shorten the locking time and simplify the code

>>>> +
>>>> +	can_tx_msg = virtqueue_get_buf(vq, &len);
>>>> +	if (!can_tx_msg) {
>>>> +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
>>>> +		return 0; /* No more data */
>>>> +	}
>>>> +
>>>> +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
>>>> +		netdev_err(dev, "TX ACK: Device sent no result code\n");
>>>> +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
>>>> +	} else {
>>>> +		result = can_tx_msg->tx_in.result;
>>>> +	}
>>>> +
> 
> (snip)
> 

>>>> +	if (!priv->rpkt) {
>>>> +		virtio_can_del_vq(vdev);
>>>> +		goto on_failure;
>>>> +	}
>>>> +	virtio_can_populate_rx_vq(vdev);
>>>> +
>>>> +	err = register_virtio_can_dev(dev);
>>>> +	if (err) {
>>>> +		virtio_can_del_vq(vdev);
>>>> +		goto on_failure;
>>>> +	}
>>>> +
>>>> +	napi_enable(&priv->napi);
>>>> +	napi_enable(&priv->napi_tx);
>>>
>>> Most of the existing drivers enable the napi(s) during the open() phase,
>>> IIUC to avoid scheduling napi operations for devices that might never
>>> get used. But here maybe there is a specific reason to do it this way?
>>>
>>
>> I do not have idea. I moved to open() and something stopped to work. I
>> am investigating it.
>>
> 
> On a second thought, it may be wiser to have the napis enabled on probe,
> to drop the incoming messages even when the interface is brought down.

It's a while since then but I wanted to drop messages not having lurking a 3 hours old cooling water temperature in some virtio message buffer being misinterpreted as an actual value. May have the disadvantage to cause load when the driver is not open-ed. But I see you also thought about 3 hours old outdated values now which may cause trouble.

> 
> (last snip)
> 
> 
> While stress testing this, I noticed that flooding the virtio-can
> interface with packets leads to an hang of the interface itself.
> I am seeing this issuing, at host side:
> 
> 	while true; do cansend can0 123#00; done
> 
> with:
> 
>  - QEMU: the tip of the master branch plus [2]
>  - vhost-device: the tip of the main branch
> 
> and the following QEMU invocation:
> 
> qemu-system-x86_64 -serial mon:stdio \
>     -m 2G -smp 2 \
>     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
>     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
>     -append "loglevel=7 console=ttyS0" \
>     -machine memory-backend=pc.ram \
>     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
>     -chardev socket,id=can0,path=/tmp/sock-can0 \
>     -device vhost-user-can-pci,chardev=can0

I had this problem when I enabled the experimental feature late TX ACK on the device side instead of immediately sending the TX ack early even when the CAN message had not yet been transmitted on the (physical) bus. In this case I relied that no ACK message (own sent message received) was lost otherwise I ran out of messages in the transmit queue everything waiting until doomsday for ACKs which would never come.

The problem was that somewhere in the Linux stack those acknowledgements got lost under heavy load on the device side. Workaround was to ack the TX message early (means putting the message immediately back into the used queue when received) in the virtio device. But this is a device thing, the device MUST put back ALL messages back into the used queue not forgetting about some under whatever circumstances otherwise the avail queue will get empty forever.

Besides that I could do what I want stressing the code and it did not stop. But this code was different from what I see now, and the testing environment was also a different one. 

> Restarting the interface (i.e.: ip link set down and the up) does not
> fix the situation.
> 
> I'll try to do some more testing during the next days.
Other than fixing the swapped feature flag values for the next release internally I've had not yet the chance to look deeply into all those changes and really to think about them in depth.



