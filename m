Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F24C0E9D
	for <lists+linux-can@lfdr.de>; Wed, 23 Feb 2022 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiBWI4H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Feb 2022 03:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBWI4H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Feb 2022 03:56:07 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129DC7C148
        for <linux-can@vger.kernel.org>; Wed, 23 Feb 2022 00:55:38 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkYkI-1o6H0I0fXC-00m643; Wed, 23 Feb 2022 09:55:36 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id D6B9B3B08B7;
        Wed, 23 Feb 2022 09:53:28 +0100 (CET)
Message-ID: <d2c1fd36-32b1-53d5-1e2c-a1171f738caf@photo-meter.com>
Date:   Wed, 23 Feb 2022 09:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Content-Language: en-GB
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
 <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
 <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
 <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
 <20220222155135.xgzxddoz372zdsv4@pengutronix.de>
 <b946db8c-ac32-afb0-95aa-8658d1176a89@photo-meter.com>
 <874k4qvq77.fsf@hardanger.blackshift.org>
 <65c90e02-e9b9-988c-bd54-235804386a4b@photo-meter.com>
 <20220222201035.ywqnclhregzmkjzq@pengutronix.de>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220222201035.ywqnclhregzmkjzq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u1vavv790iLZyypu//ZOIIaDEuWHURsyPUnCUzgPvk4uDqdXEn2
 /3tDCvdOucrFhvRl/6YKtFdPm+9pv23GeVvAiStBOnYy9meNz+qv97auFnBXXroB9PtvnNs
 33sXAXoSwqoaJPjfKt/k3+2mbmeuSRfFUOIILCix3TaV7cmZOuWseAM+22U85UScJwQI6aP
 8JITHHrYr3WLwGfi8b9aQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+GPLy8Xcy6s=:SS9NLdytp+fOhfcyjOoqZQ
 bU3x3LM9Ua2vz22WAK1Ii62b8yx1sovP4UOGlQMqPMPQ2lvyL0vXUUoxbebUjOmQF4+kbmy1O
 FaSJITPDFexA4xQZQ1qfLwryTGAm01LlqMtFCm+imD2luydzePGMqlIK02DlAzOq6rLWGp0Sq
 AhHJKot95l8xaU41WLI2AceVxrcn/RH0Rr6diyYIzsHlpLdngcNhjJkzjsm2vN63wwbemstz7
 /65tQLkwQ4y6TEtyb60or2Dx5XoYNXMdLFhDrRf9WU2xZPSK9wjRstHA3l20dbhVTMK3Y0R8O
 PxboOKdd5+5x+0BzKRLaYZJ4xafg0QBdpt/JyfIbhQgCyhuVS9Zm/kFJuXqxJ6gYM9AFxQc0R
 U33HIsKMCXmF0F2o1KBKngUCt3gJxgIXQLfNNroEsPiz/I63lo1E3JNAXxmM1NqFwqxMMTyfn
 et6A1uDM/bVouycX66FGmxg8LxJBwKzutxjdzcw0LAw1np+dHHNcTQ9g4LU7Nrlj8RdhAay3E
 sO6cv8QY3dvcuL2dbE8XgIJQHuRhob2ik/hISzMNZOrdSPzA33aFlxPgpdbA12LXQSK6CYKCi
 9etqagqDkZeU8umlLLjAfB+88wLo95q3TD7pQOhch3GTbbBbkSl4tYxsFeUdGuDbSGr1Y2FLW
 8NolvZHf86wVhHIJIwJvVuKzAwdXJWMUZW1gNMwD+oC5HAhLvIAVDCVu0EHzILERcYH16mUqV
 C+u5rJvsmUyZl997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> 
> BTW: it's documented as level low in the bindings documentation:
> 
> |		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> 


Thank you very much. That was my false hope, I change the dt_binding for 
IRQ_TYPE_LEVEL_LOW=8

interrupts = <25 8>;
interrupts = <27 8>;
interrupts = <16 8>;

But without success, failure still occurs, maybe not so fast as with 
IRQ_TYPE_EDGE_FALLING (subjective). Interestingly, the first run after 
reboot may last longer than subsequent ones until it breaks. If it 
breaks, the interface is at random can0 or 1 or 2.


Here is an example, can1 brakes.  No more ISR fires after [ 1682.748485].
I added netdev_dbg before return, and netdev_ERR for out_fail.


[ 1682.747310] tcan4x5x spi4.0 can1: m_can_isr: enter ir=0x5800
[ 1682.747468] tcan4x5x spi4.0 can1: m_can_isr: netif_wake_queue done
[ 1682.747475] tcan4x5x spi4.0 can1: m_can_isr: return IRQ_HANDLED

[ 1682.747494] tcan4x5x spi4.0 can1: m_can_start_xmit netif_stop_queue done

//Last TX ISR (IR_TEFN was true)
[ 1682.747912] tcan4x5x spi4.0 can1: m_can_isr: enter ir=0x5800
//fifo not full and queue is stoppet -> wake queue
[ 1682.748053] tcan4x5x spi4.0 can1: m_can_isr: netif_wake_queue done
[ 1682.748061] tcan4x5x spi4.0 can1: m_can_isr: return IRQ_HANDLED

//Last RX-ISR
[ 1682.748199] tcan4x5x spi4.0 can1: m_can_isr: enter ir=0x1
done
[ 1682.748433] tcan4x5x spi4.0 can1: m_can_isr: return IRQ_HANDLED

//In m_can_tx_handler after fifo write an end, m_can_tx_fifo_full -> 
netif_stop_queue(dev);
[ 1682.748485] tcan4x5x spi4.0 can1: m_can_tx_handler m_can_tx_fifo_full

After that I expect m_can_isr with IR_TEFN flag in order to wake queue, 
but nothing follows. Write to socket returns permanently 105,ENOBUFS

Full dmesg output: https://pastebin.com/G0xikf3P

Maybe I should add some printk to skb.c and deb.c?
