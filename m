Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D124BFF0D
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiBVQmY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 11:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBVQmX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 11:42:23 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011166F8C
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 08:41:57 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mvbr4-1oD0Sq49Ru-00seFs; Tue, 22 Feb 2022 17:41:55 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 661643B08B7;
        Tue, 22 Feb 2022 17:39:48 +0100 (CET)
Message-ID: <65c90e02-e9b9-988c-bd54-235804386a4b@photo-meter.com>
Date:   Tue, 22 Feb 2022 17:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
 <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
 <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
 <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
 <20220222155135.xgzxddoz372zdsv4@pengutronix.de>
 <b946db8c-ac32-afb0-95aa-8658d1176a89@photo-meter.com>
 <874k4qvq77.fsf@hardanger.blackshift.org>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <874k4qvq77.fsf@hardanger.blackshift.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8CBGEq/CyxYHF7sAB6aouzgxY5Gt1oIZ5hxWlTxRBzS3arHMZ5A
 B/bEsq24dCamefiqG9d6vomVadbC92vy3rIN9gH15W+sgDrdxojfkCZQixgASw8HltoMEtc
 Ses0EoWv0flxPhPqKXpuZiOOpj/sQRXArNf+f/6FmOysuQdbdsys5SS8d4n4q3ESbtLMPux
 ESG8Gvffe9u0o2z3ejUeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sh2EUxTJI+I=:TqSJ5PZWxACwunDPng7i/P
 eWZxZAGbpQJMn+nVmHO1BwXz/a9wdoeprOvDgyVDku4pV2EJbOqRVYHqva9FlqiT8NfsIrpuT
 kk7oY14oAv4ccqQj2mHEhjZQEA/L0254xYXwXEmfW22gC/If4JtlnI7DaM5PWpbbCqC+sSyhF
 UcbMr59Vb8cPrxFTc5RA/+YfT7PFdzLc9eq+FKbU/+cLUMguKCI/Z6EJ+g/7mEdZFxuD30CZF
 cXBenvVGH5jMKXoXRVeItXmx3F/KI3QXuUKsMp7Pji5/wLAT+0kisa4zpB3YSupPAYF/0OwOU
 ftRUfarPq1tijtPo1TyoZQxhw+CiDLKxxBEad81uKLeKcDtBjDUB1AkE9GjX++Zf92UskqLVf
 QNsMha2QbJgypgRHF2iB/iRuLLEiENEClgOL1RXCDJn6L5vb9vhMXtVb1qt5A9dPCAqmYXjBA
 cJK1gA7YGtEpfxY35Hf2yJ3+ymWxuB2HBw/0gFXIkpWI7yjL6ZGDOGJl901z1FAOfEEEb0O7f
 1MpTuBzbzL4iCTa/gqxvr9ZEd4i2aRrHIKCTopm4328Um5kqUUtHM6fYjrwn/B1K9NHHT5bqs
 LyBLLQ5qp+3gtiYAdIRbkkPBgLIQIVtE8D2Ucw92kgbB6Imi9E47XojgXa1EBrOdEWP1VHT8Z
 rRX+U/RF5w7sOem6o/mXjWxhciR3x1VFx2B4INYTOYB/0wlKtvVSeqzBUVef8peV7Zd3pQqqa
 mDNZhhWxUDnAYMwl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


> You're missing a "netif_wake_queue done" here. There's probably an
> interrupt associated with this event. Add a print if that IRQ is active
> right after reading the IRQ status register

Done, only on enter in m_can_isr "m_can_isr: ir=", not exit.

If there are a RX traffic on but, the latchup happens very quickly.

Last dmesg lines from https://pastebin.com/yBv9xcWg:

[  396.390714] tcan4x5x spi6.0 can2: m_can_tx_handler m_can_tx_fifo_full
[  396.390955] tcan4x5x spi6.0 can2: m_can_isr: ir=0x5800
[  396.391091] tcan4x5x spi6.0 can2: m_can_isr: netif_wake_queue done
[  396.391109] tcan4x5x spi6.0 can2: m_can_start_xmit netif_stop_queue done
[  396.391282] tcan4x5x spi6.0 can2: m_can_tx_handler m_can_tx_fifo_full
[  396.391534] tcan4x5x spi6.0 can2: m_can_isr: ir=0x5800
[  396.391670] tcan4x5x spi6.0 can2: m_can_isr: netif_wake_queue done
[  396.391689] tcan4x5x spi6.0 can2: m_can_start_xmit netif_stop_queue done
[  396.391865] tcan4x5x spi6.0 can2: m_can_tx_handler m_can_tx_fifo_full
[  396.392134] tcan4x5x spi6.0 can2: m_can_isr: ir=0x1
[  396.392537] tcan4x5x spi6.0 can2: m_can_isr: ir=0x5800
[  396.392673] tcan4x5x spi6.0 can2: m_can_isr: netif_wake_queue done
[  396.392692] tcan4x5x spi6.0 can2: m_can_start_xmit netif_stop_queue done
[  396.392862] tcan4x5x spi6.0 can2: m_can_tx_handler m_can_tx_fifo_full


