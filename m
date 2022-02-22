Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310384BFC0A
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiBVPMY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiBVPMX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:12:23 -0500
X-Greylist: delayed 98296 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 07:11:55 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62011AA28
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:11:55 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2EHo-1oNWXG3ZEM-013fR4; Tue, 22 Feb 2022 16:11:52 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 48D143B08B7;
        Tue, 22 Feb 2022 16:09:46 +0100 (CET)
Message-ID: <eaa035dc-d6d9-182c-5ee9-fba4012ccba1@photo-meter.com>
Date:   Tue, 22 Feb 2022 16:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
From:   Michael Anochin <anochin@photo-meter.com>
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Reply-To: anochin@photo-meter.com
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
Content-Language: de-DE
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:98RUutnz37GHwYbMDAsqYcjUfo4VInDNQ/HjNIfN9l1/wJYReaX
 MTRIJavvoLAKNJdrnwlnM/HHqGGF358tRhBWmf/MvKSIFNyDPP2PogUC6KIgD96w4RkrubC
 SDisPsyBxIHsI3LfVycRTH9139uCiKUz8bHU6n5zBi028vC03E25ixmZSSwTTO40E1fGT8v
 Sg2FFVdLJvXm87GSyDPgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/SbtGldwXMA=:UUcYiS0NpbLDhTxWsccZoJ
 BrcyXWFxuGsWqJd2WBmq4pErIE69KtFCtrfSS3zd237Je0pn/7B3/CbEkuKuLWQ2e9q4YmAi9
 C0Tgo3AAwpVD+OmxnXrW5jwDyUZ/uqmQ/yzOAoFraETgSMdvXmgsa7qbimvcFpoVZIQNR1IBE
 RaldP8O0VpRswI6zkdukRthZhmHPeh8UU+QGXnSbx+4ffIILDEiNYFg9/FnjEEXr32pEsliJ/
 5NZ72+l6iuJLlOJNQHe8GkNBz81buU/VN/sBluBesoCrBiYtNoIPY7zsmt5YyMDcsE56kpkHD
 vDgcPlB9mVceEU+whRbIZ19JFNDwRYAxMU0hmwRZd3lTr4OCFRa+k5ZubXjVmxe38LMFPOrVS
 PEupeMlwZLSypdwH/dy3RC7+4UBxv1JDv68mXrYEzbseG76csl3VGzDkKSK98qdjBeHZiQrYh
 +vqXqdSGd3TPgbqNfUDT3T2cyZVs16oCkCxKOI+4pHVBCif4sX6F79+F8C8p4F9OZhq62R5q5
 SFlD1VsDdVwV/OJ2EkKbiECbSPC7LuiP6IjbCzKgB46ZENghRN2wP6ZIa7/JsEuBK5AkvVWdO
 F6cs7JBdeQ4/C+3N93RjbJuqZXitgGWTN9r4p7QJRu/55Qzg3BbGVoFlOjAkPl4WiU8u6dcsT
 ZBuRYWQRPl+xIsrF2ta4sTXXVGu+igePz6Q0qEueeE4ntYzSRXOKZM0nApfeX0BOrebIhqrFF
 QvEpoO2Hx+Ri9spW
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With netdev_warn() in m_can_tx_handler I found,
that before "BUG! echo_skb N" appears,

m_can_next_echo_skb_occupied(dev, putidx) is true with putidx=N-1



[11676.933800] tcan4x5x spi4.0 can1: m_can_tx_handler m_can_tx_fifo_full 
or m_can_next_echo_skb_occupied, putidx=12

[11676.934735] tcan4x5x spi4.0 can1: m_can_start_xmit: enter

[11676.934744] tcan4x5x spi4.0 can1: m_can_start_xmit netif_stop_queue done

[11676.934911] tcan4x5x spi4.0 can1: can_put_echo_skb: BUG! echo_skb 13 
is occupied!

