Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9373650
	for <lists+linux-can@lfdr.de>; Wed, 24 Jul 2019 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfGXSHy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Jul 2019 14:07:54 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:27340 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGXSHy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jul 2019 14:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563991669;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fimCrpc5LexTTlta2PCdsvThC/ChCBVjJE62kHUKkFQ=;
        b=CSsXP7CUlVPyW0ilxiGm6JN24Sj8elOaQfn7XJ/95MKvTvSTC9aS2qB6Je4LAPc6cH
        Om94jMGET/LH+1I7Denaimlp2hozYD/g41ZdWVC5A1Cu1UMv7KbJyfVrfiassgkcg4/8
        QUgBPDaNT2D+erSBHqlu6q0rX8Z8CjQkxvcxxTPaNAKU9FwbhnHf+MbEfVlpO5E5z7wr
        3JQg7IEkGcC+mWzOjgYqV3voULzEO3NTVm8hWWdB5wzCAGWGCY0g3rbtEPd0FAp9kiOr
        WEmS2ehsM2Yc+zCny/nbVosOtCP//ZMUCO9Tw62KhaaQEwymzJPW2QDE0sTVIlf86b6I
        iEpA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h5l0Tb"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.200]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6OI7liFz
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 24 Jul 2019 20:07:47 +0200 (CEST)
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
Date:   Wed, 24 Jul 2019 20:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 24.07.19 15:36, Marc Kleine-Budde wrote:

>> @@ -425,23 +502,22 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>>   		int max_len = nskb->len - offsetof(struct canfd_frame, data);
> 
> I know, this is original code...but max_len can either be 8 (for CAN
> frames) or 64 (for CAN-FD frames)? Because we always have full can_frame
> or canfd_frame in the skb, right?  I assume a lot more will break if the
> len neither 8 nor 64.

Yes. The code has been added recently for commit 0aaa81377c5a0 ("can: 
gw: ensure DLC boundaries after CAN frame modification") to check the 
data length after the CAN frame modification.

And yes, we only have proper CAN (FD) frames in our skbs which have a 
special ethertype :-)

>>   		/* dlc may have changed, make sure it fits to the CAN frame */
>> -		if (cf->len > max_len)
>> -			goto out_delete;
>> +		if (cf->len > max_len) {
>> +			/* delete frame due to misconfiguration */
>> +			gwj->deleted_frames++;
>> +			kfree_skb(nskb);
>> +			return;
>> +		}
>>   
>> -		/* check for checksum updates in classic CAN length only */
>> -		if (gwj->mod.csumfunc.crc8) {
>> -			if (cf->len > 8)
>> -				goto out_delete;
>> +		/* ensure a valid CAN (FD) frame data length */
>> +		cf->len = validate_len[cf->len];
> 
> This looks strange to me, but I cannot say if I don't userstand this or
> if there really is a potential problem:
> - first you calculate max_len
> - the cf->len > max_len is discarded

Right. In this case the frame modification leads to a length value 
beyond 8/64 byte, which is then discarded.

> - but then cf->len is "rounded up" via validate_len[].
> 
> What's the purpose of the last step?

Ha, good question :-)

The reason for this results from the non-linear data length code for CAN 
FD data length.

For CAN you can have 0, 1, 2, 3, 4, 5, 6, 7, 8

For CAN FD it is 0, 1, 2, 3, 4, 5, 6, 7, 8, 12, 16, 20, 24, 32, 48, 64

If the CAN FD length was 12 before the modification and the modification 
was to "set bit 0 in the length field" then you get 13.

But the length value of 13 is an illegal value for CAN FD length and can 
not been sent by a CAN FD controller.

Therefore we need a round-up to get the next valid CAN FD length value 
(in our example it get's from 13 to 16).

Regards,
Oliver
