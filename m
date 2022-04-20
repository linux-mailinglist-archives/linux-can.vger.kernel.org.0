Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4137E5087FD
	for <lists+linux-can@lfdr.de>; Wed, 20 Apr 2022 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiDTMYg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Apr 2022 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353140AbiDTMYf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Apr 2022 08:24:35 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B636B49
        for <linux-can@vger.kernel.org>; Wed, 20 Apr 2022 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1650457305;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=6yvwJTwUvO7q6gvQkS0S3qI/o++YZI4m7dYWdPD35/Q=;
    b=O0NifV4k1oqbn+IcnDewKH4r+PdSiUZxYUmh5F7iPVgmy5CM7k0nV85zhvhQ53++3h
    Hq0iMQMKzxkWyC5KCu4w8nWnIIvLXNARHnm2evQMOBbX2hWRQCF1fvhTCWlwmmYLIiPb
    PuDH81GZejuVu4bMVgOwSJ5wSte3D9gfXDS9zM0UmTIAaybVWhqdmP957R5FNGCXTT33
    JW8/aPOFrfRmR/ZiDV7NlM3oWu4jfNQ6LVex6OT4oFLqb/MOCg5SZ4Z5BDS7YkEO1i4g
    Y/qLg7rfcwSLvrLzCWCn+6xa5cwK73LsYtPePNsEekG7Fr0mZ0+vFaq4+i7l8nUuxnBM
    WXfg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+Gi68g=="
X-RZG-CLASS-ID: mo00
Received: from [100.82.11.40]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y3KCLj367
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 20 Apr 2022 14:21:45 +0200 (CEST)
Message-ID: <3bb95a07-1bf5-8fff-731c-221b2ae6c3d1@hartkopp.net>
Date:   Wed, 20 Apr 2022 14:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: can-isotp: TX stmin violations
Content-Language: en-US
To:     =?UTF-8?Q?Maik_Allg=c3=b6wer?= <maik@llgoewer.de>,
        linux-can@vger.kernel.org
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
 <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
 <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
 <19adffae-443c-78bc-fb8c-61ec792a7b6d@hartkopp.net>
 <20220114141929.mz34evi65cgurgek@ganymed>
 <20220114143113.zapz2oszjzfq6p7r@pengutronix.de>
 <20220420093402.mjyz6lkmgavnxmc3@ganymed>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220420093402.mjyz6lkmgavnxmc3@ganymed>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Maik,

On 20.04.22 11:34, Maik Allgöwer wrote:

> so I hoped I would not have to bother anyone with this issue again,
> but our customer wants this fixed.
> 
> I am wondering whether someone could point me into the right direction?

In the upcoming Linux 5.18 I reworked the consecutive frame transmission 
flow in a way that the next CF is only started after the last frame has 
been sent successfully:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b7fe92c06901f4563af0e36d25223a5ab343782

This new concept will not be back ported to the out-of-tree 
implementation on GitHub.

Are you able to build you own kernel for $CUSTOMER to probably use this 
latest implementation?

I had to go back in the mail thread to check your issue and this 
improvement could probably fix it.

Best,
Oliver
