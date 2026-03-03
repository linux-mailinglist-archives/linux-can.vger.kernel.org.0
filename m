Return-Path: <linux-can+bounces-6852-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABNMGUzvpmlKaQAAu9opvQ
	(envelope-from <linux-can+bounces-6852-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 15:25:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFD1F169D
	for <lists+linux-can@lfdr.de>; Tue, 03 Mar 2026 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3773D30493B0
	for <lists+linux-can@lfdr.de>; Tue,  3 Mar 2026 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64833D525B;
	Tue,  3 Mar 2026 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4UmdC54";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ6I30Ul"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F573DEAD9
	for <linux-can@vger.kernel.org>; Tue,  3 Mar 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547609; cv=none; b=iVG/crcQT8nXlFFiLB874Qngt0hFCZpF9fRigoFClx0CnEdhbMZOsV3ZuoGHdEnxwe8zd/ax2HkMr24oLf8M0yvsUobaDlZ7XE+Ctv0MJ73BMvOZIp1OyR6nQnyiwBCnfi5m1eNYCiBb9xrOvcre9pz0xesCtXz1yXq3nKk1eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547609; c=relaxed/simple;
	bh=PEJ6AUJ8333z6GPyIzveddG5FlyIB4BbeK84ZRWRQHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDtzh45O/II0yIgxLY5xwvr2hUszFBYKLg88Aa/xhwZVMffptLAHTExsa/5MLs0BjgMZDXeR0mBK8MnKWYqZIS2MvvrsaQ1OBt2Ga8m3MrodhNtGUKvsl2qIRQjEqGuZFr/mCLj/oLt3h5DHTRtnrKLvIG1qgjsjAXu9BaDh5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4UmdC54; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ6I30Ul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772547607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s9zZgNEufD6K1eLCHPNh64qMlE76Gg0EOHAgj4XR9+4=;
	b=E4UmdC54oAWxWiI7pTSBDHjVzYbCOiSD+Fb0tYtYHo6GcQcL+ZzaQ7AZlRZGd1yi1pZON5
	hseROwnvFA0dOMJa5l1RAFiy8osyGbdfs20QO4YY8zFgjCz+63IqChe03p87YSUZGjH0a7
	vrh2cvCSzj2UV5vM0PAf+7NxuZwtdKg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-HRnokF4dM3iXDt-Awrx_LA-1; Tue, 03 Mar 2026 09:20:05 -0500
X-MC-Unique: HRnokF4dM3iXDt-Awrx_LA-1
X-Mimecast-MFC-AGG-ID: HRnokF4dM3iXDt-Awrx_LA_1772547605
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48378c4a79fso48648075e9.0
        for <linux-can@vger.kernel.org>; Tue, 03 Mar 2026 06:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772547604; x=1773152404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9zZgNEufD6K1eLCHPNh64qMlE76Gg0EOHAgj4XR9+4=;
        b=KJ6I30UleCBUraTjR94aB+LOPFYZ18HfWs+w93g+FXfS428n1IgM3Vn30Vyh47Oyg+
         ijaB6DM1myx4anLm0/P1KgFhsumyWzBOrd0dgnrdUPQMyPSHk+BFJFe1PoUrUZ/nu8HG
         6wNFkK2gjpeEiAN9pUPo4z61jWjK7Qpd+KTED4ye7caC9oB5+nCXCtPW6cKc4BnqWNQ7
         aXc9cZLzMLaYNTxR2oSItvKcvko5zzsLdhY4vscixxaWm3OIwecuJYjyYklEMF6ktW16
         emIw4jcUBM3Cs6c20vOFG9zWYr8YW+AYySLYhfHCaHvWAdItBq4BpWb9vULXIFZW8Wo9
         Su+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547604; x=1773152404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9zZgNEufD6K1eLCHPNh64qMlE76Gg0EOHAgj4XR9+4=;
        b=ejvcIyGKiZcM2L4LBcEnh3JjcfyK5XXJAI/kK3AbfxYIkvF1ZFqC3aeVeubEgSLHy3
         RTUAVBJOaIXU0mpq8/y5AQe9/mjcU0jyZ6v+5U3SkBQW6CVuydcLhKi1ZqWJUY2JEJt/
         zFUZ6Tot+FIyURN8J9USP8vxQfbxJ2dynVDrtBvh8d9Tb1gBi7eClHRtb1du6Nw/V0o1
         Rk8kZqvltZg1BOJWCP9jQsjb9EwhgE9QUS5mc6/Xu3G/sNqYuGRxdjnuwd3Ft625W8Fi
         2G4vA8STfbPxUu6iYJXDDM6k1wfzfQlaxvbsYHsboanjH6y2dNzBaJsGF0dnh8CjXPc7
         lQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCbTnbiCG60oJYWTILOlpmF1uzS5bBabfrxUGAAk8WXYmorR+UnrNbMsGGQdd9P1o/jYulha0AWsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/l2LIkL3hFf2PYtAX/qRxzid01dwHHcGMrgh4PmcOQbND0QT
	w+Ng+wX2HYIPzfiihmvccUGQMMUIh9jTRa6hgzOM5DVVoQudgPH+GCOOxbNoWSBj+nncRvgEwEu
	noPfqPjtcNGJ+fvANfEB+nsEB7UAATrRunUhMafsbkF5a1zxFQ4YePeAnDi87fCO8z/kobQ==
X-Gm-Gg: ATEYQzyv2TylslB/9BnUAmU2CI3giMl9+hq9/cYDh2EoNFCqFOuvom80f2v+bfGxta0
	4BXaVkZkTmasjH35F7SW6ZNgHdO5QKnzIrtlIqczJt1DiGJpsMkyipDo+s7QFZxlb+azaTuNegw
	hd65DJdDQgJ2j1CJUha5guvXK3p4DPYHXbCQSAC7GVX2ds9Xf2sjJNsZ77+5XeVuNhG5/ePXJAc
	i5ZP0vcKXtbFd5HhSoS4QtqEYXA0g9A84GiOH2dfrkhR+Iu4nE+ywYfD0NKiF92hO7Ai6LFGx43
	QpSFzG87+C5QrUOvFcubzulnAz008xAhJ82kG6sUKsPtxcFqHmQgDOB2RVLumktBBDGOopMcKld
	TEsd5ih4TB7biim0Y9Gf+Q1cy
X-Received: by 2002:a05:600c:8711:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-483c9b970a5mr262967525e9.7.1772547604240;
        Tue, 03 Mar 2026 06:20:04 -0800 (PST)
X-Received: by 2002:a05:600c:8711:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-483c9b970a5mr262966805e9.7.1772547603697;
        Tue, 03 Mar 2026 06:20:03 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f3124sm481248085e9.1.2026.03.03.06.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:20:03 -0800 (PST)
Message-ID: <7c39c1dd-dd49-4847-9238-d6cf147598da@redhat.com>
Date: Tue, 3 Mar 2026 15:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/12] can: ems_usb: ems_usb_read_bulk_callback():
 check the proper length of a message
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
References: <20260302152755.1700177-1-mkl@pengutronix.de>
 <20260302152755.1700177-6-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302152755.1700177-6-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 66AFD1F169D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6852-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/2/26 4:16 PM, Marc Kleine-Budde wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> When looking at the data in a USB urb, the actual_length is the size of
> the buffer passed to the driver, not the transfer_buffer_length which is
> set by the driver as the max size of the buffer.
> 
> When parsing the messages in ems_usb_read_bulk_callback() properly check
> the size both at the beginning of parsing the message to make sure it is
> big enough for the expected structure, and at the end of the message to
> make sure we don't overflow past the end of the buffer for the next
> message.
> 
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: stable@kernel.org
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Link: https://patch.msgid.link/2026022316-answering-strainer-a5db@gregkh
> Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/ems_usb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 4c219a5b139b..9b25dda7c183 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -445,6 +445,11 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
>  		start = CPC_HEADER_SIZE;
>  
>  		while (msg_count) {
> +			if (start + CPC_MSG_HEADER_LEN > urb->actual_length) {
> +				netdev_err(netdev, "format error\n");
> +				break;
> +			}
> +
>  			msg = (struct ems_cpc_msg *)&ibuf[start];
>  
>  			switch (msg->type) {
> @@ -474,7 +479,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
>  			start += CPC_MSG_HEADER_LEN + msg->length;
>  			msg_count--;
>  
> -			if (start > urb->transfer_buffer_length) {
> +			if (start > urb->actual_length) {
>  				netdev_err(netdev, "format error\n");
>  				break;
>  			}

AI noticed the following:
---
Does the check validate enough of the message? The code checks that the
11-byte header (CPC_MSG_HEADER_LEN) fits in the buffer, but
ems_usb_rx_can_msg() and ems_usb_rx_err() both access fields in the
msg->msg union payload starting at offset 11.

For example, ems_usb_rx_can_msg() reads:
- msg->msg.can_msg.id (4 bytes at offset 11)
- msg->msg.can_msg.length (1 byte at offset 15)
- msg->msg.can_msg.msg[i] (up to 8 bytes at offset 16)

Similarly, ems_usb_rx_err() reads:
- msg->msg.can_state (1 byte at offset 11)
- msg->msg.error.cc.regs.sja1000.{ecc,txerr,rxerr} (3 bytes at offset 11+)

A malicious USB device could send a packet where actual_length equals
CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN (15 bytes total), which would pass
this check but provide zero payload bytes. The callees would then read
beyond the received buffer before reaching the second check at the end
of the loop.

Should the validation check that both the header and payload
(msg->length bytes) fit within actual_length before calling the
processing functions?
---
I guess this patch could need a follow-up? Not blocking the PR, as
AFAICS worst case this patch still improves the current situation.

/P


