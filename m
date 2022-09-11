Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B225B4ECE
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 14:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiIKMfl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIKMfk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 08:35:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E321D2DA85
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1662899732;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7QVcGUvv5lTYj5hyRMZnH39DTnNUm4jDc+7KKR3dqTI=;
    b=UwwMUSLE/7VQlSKTuOpU/5inpDwA2Aq8Exu24O4PhBvBjptpsxqe4/Z6IO8ZgiMgkj
    wHYhgcwiyxXYoPY+BLk+IWPCnhd2LAZ+a1riJqSLzQAyMIsHqq6y+hQa8zR/AUNEml8M
    +k3vHFJ4JzAE1pB5DaQOnUIvyH5Ylw79XnFXFY9O8CQiwO0cMdQ3CRhr01foWa3uI+9k
    YzEMcj2IiaQsrTpi0ZrgwC8mUSB/ppOP1AYGyl+TUDjaJgZKaNzjDd+Lo2ruW9lgCXMG
    K9QOdhmjlpcxIRpKgOE54ODrWlbRQ04XGG16mQUMKKCYsLAV9sV5ZOLkSVy9XJFfLjBd
    nbBQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytISr6hZqJAw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d104::923]
    by smtp.strato.de (RZmta 48.0.2 AUTH)
    with ESMTPSA id wfa541y8BCZWCpR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 11 Sep 2022 14:35:32 +0200 (CEST)
Message-ID: <5867dc1e-36d7-d0ea-7d1d-56ea31ac19b8@hartkopp.net>
Date:   Sun, 11 Sep 2022 14:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 5/7] can: canxl: update CAN infrastructure for CAN XL
 frames
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <20220801190010.3344-1-socketcan@hartkopp.net>
 <20220801190010.3344-6-socketcan@hartkopp.net>
 <CAMZ6RqJMTP8mO5LOgfdFHNAkrn+3bCP9_JcGb4Q86TtHiS100A@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJMTP8mO5LOgfdFHNAkrn+3bCP9_JcGb4Q86TtHiS100A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 11.09.22 09:53, Vincent Mailhol wrote:
> On Tue. 2 Aug. 2022 at 04:02, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

(..)

>> +/* get length element value from can[|fd|xl]_frame structure */
>>   static inline unsigned int can_skb_get_len_val(struct sk_buff *skb)
>>   {
>> +       const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>>          const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> 
> Nitpick: what would be the acronyms for cfx and cfd? I thought that
> cfd was for *C*AN-*FD* frame, and thus I would expect cxl instead of
> cfx for *C*AN-*XL* frame.
> On the contrary, if cfx stands for *C*AN *F*rame *X*L, then for
> CAN-FD, the acronym should be cff (*C*AN *f*rame *F*D).

You need to start from the original

struct can_frame cf; *C*AN *F*RAME

Then CAN FD showed up and the naming moved from 'cf' to 'cfd' for *C*AN 
*FD* FRAME where is was not forseable that there ever would be CAN XL.

For me it is more intuitive to generally name CAN frames 'cf<whatever>'.

cf -> cfd -> cfx

So it is about 'cf' with an extra attribute and not an abbreviation of 
CAN variants.

Best regards,
Oliver

