Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D298A5BF7A4
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 09:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiIUH0v (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 03:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIUH0u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 03:26:50 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Sep 2022 00:26:46 PDT
Received: from libero.it (smtp-34-i2.italiaonline.it [213.209.12.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C3832EE
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 00:26:46 -0700 (PDT)
Received: from oxapps-36-168.iol.local ([10.101.8.214])
        by smtp-34.iol.local with ESMTPA
        id au73oPSeCMK28au73oNcd4; Wed, 21 Sep 2022 09:25:42 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1663745142; bh=l+vsPagSkNwPkkT9bWVvch2ijeH5veHxAInjgMuIz4A=;
        h=From;
        b=UrJ0/xoYl9Oe6aFpIFfr9U7xCFbfqdg1CiHjCxKQBsCG8Ywm2Idk40SXPfBIWGSB2
         ofJVpPQHIhsebUzqkJ9AakJLW9KkQOyQyqyl+h53fWYaopaOKAZyi3Q0a3nqgBU9eH
         JcUPIb3sQHHCKsvl2NP3Kgw9ZVEr6Egz0VIx+oDXqP0MRiEZWFUjadDq0wnW/kblqh
         LQe8DAxGg+001Qy5EXbz0eQv/1tgp4WWqBM8ULeIq2T8jouQTNlQFK1H/CptvGsVd/
         jFtRvbeDVQkLVbB96SLRGPSkxQSEOnHKgAu+xkbq4b28sKjeRhUw7/uuo79nFMSfln
         Bhs3hWY7z5xYQ==
X-CNFS-Analysis: v=2.4 cv=a6H1SWeF c=1 sm=1 tr=0 ts=632abc76 cx=a_exe
 a=3iLpBvWwvOdkg4efS1Ji/Q==:117 a=KtRsck1nP08A:10 a=IkcTkHD0fZMA:10
 a=NT8mcSYMf2YA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=fGO4tVQLAAAA:8
 a=KOQ1JtDKSoI41Hg3RDwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Date:   Wed, 21 Sep 2022 09:25:41 +0200 (CEST)
From:   dariobin@libero.it
To:     Jacob Kroon <jacob.kroon@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Message-ID: <541998938.482927.1663745141832@mail1.libero.it>
In-Reply-To: <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev48
X-Originating-IP: 95.232.92.192
X-Originating-Client: open-xchange-appsuite
x-libjamsun: JQuCMaBwiAiX1LOfFoYpnFZkWoPk8wIU
x-libjamv: mECM7YLwXdY=
X-CMAE-Envelope: MS4xfI3o6/jh58AOmu8Lpz4fyzRKGcFg4rs79WwzBBKQhYLFFu3ii2UcReDTKcWVozXAgpLByLrZHzfxjBf/FSvjVHtG57Vn0kTytU2znMVvloYPfa9eaotD
 4YybPiGSup5FupL8QAl65Ybz8D9Gg9KH6+ft87I0zmg51n1aiJNKrDyTcPB+YBJ2VElnqzCp/MsQikRIWyP7O5u5IioPsW7/Ge19izVf1gJN4CwCn/my8KP7
 k5F8opoFM57Zk08wuCk0/ZJVXg0stiAbjCVpa/Su8mCzT9wKjadG1NyUsW8C2JPcrmxsoEpA1poc61nCDDFetnaN9sf85EvN9VnVW5Q/tro=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jacob,

> Il 20/09/2022 01:24 Jacob Kroon <jacob.kroon@gmail.com> ha scritto:
> 
>  
> Hi Marc and Dario,
> 
> On 9/16/22 06:14, Jacob Kroon wrote:
> ...> What I do know is that if I revert commit:
> > 
> > "can: c_can: cache frames to operate as a true FIFO"
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
> > 
> > then everything looks good. I don't get any BUG messages, and the host 
> > has been running overnight without problems, so it seems to have fixed 
> > the network interface lockup as well.

Here's what I think:
If one or more messages are cached, the controller has to transmit more frames 
in the unit of time when they can be transmitted (IF_COMM_TXRQST), different from
when the transmission occurs directly on request from the user space. In the case 
of cached data transmission I therefore think that the controller is more heavily
loaded. Can this shift the balance ?

> 
> I ran the kernel *with* the commit above, and also with the following patch:
> 
> > diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
> > index 52671d1ea17d..4375dc70e21f 100644
> > --- a/drivers/net/can/c_can/c_can_main.c
> > +++ b/drivers/net/can/c_can/c_can_main.c
> > @@ -1,3 +1,4 @@
> > +#define DEBUG
> >  /*
> >   * CAN bus driver for Bosch C_CAN controller
> >   *
> > @@ -469,8 +470,15 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
> >  	if (c_can_get_tx_free(tx_ring) == 0)
> >  		netif_stop_queue(dev);
> >  
> > -	if (idx < c_can_get_tx_tail(tx_ring))
> > +	netdev_dbg(dev, "JAKR:%d:%d:%d:%d\n", idx,
> > +	                                      c_can_get_tx_head(tx_ring),
> > +	                                      c_can_get_tx_tail(tx_ring),
> > +	                                      c_can_get_tx_free(tx_ring));
> > +
> > +	if (idx < c_can_get_tx_tail(tx_ring)) {
> >  		cmd &= ~IF_COMM_TXRQST; /* Cache the message */
> > +		netdev_dbg(dev, "JAKR:Caching messages\n");
> > +	}
> >  
> >  	/* Store the message in the interface so we can call
> >  	 * can_put_echo_skb(). We must do this before we enable
> 
> and I've uploaded the entire log I could capture from /dev/kmsg, right 
> up to the hang, here:
> 
> https://pastebin.com/6hvAcPc9
> 
> What looks odd to me right from the start is that sometimes when idx 
> rolls over to 0, and *only* when it rolls over to 0, the CAN frame gets 
> cached because "idx < c_can_get_tx_tail(tx_ring)".

If the message were not stored but transmitted, the order of transmission 
would not be respected.

> 
> Is it possible there is some difference between c_can and d_can in how 
> the HW buffers are working, which breaks the driver on my particular HW 
> setup ?
> 

I tested the patch on a beaglebone board without encountering any problems.
There is also a version of the driver I submitted to Xenomai running on a custom
board without problems. But surely the setup and context is different from yours.

What compatible are you using in your device tree?
I used "ti,am3352-d_can".

Thanks and regards,
Dario

> Regards,
> Jacob
