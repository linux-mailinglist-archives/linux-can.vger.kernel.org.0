Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32AB4BFE5D
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiBVQVQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 11:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiBVQVO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 11:21:14 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260D166A66
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 08:20:48 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MoeU5-1o2FRj2GhV-00p5LY; Tue, 22 Feb 2022 17:20:42 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id E28523B08B7;
        Tue, 22 Feb 2022 17:18:35 +0100 (CET)
Message-ID: <90d5ea40-6357-4b9a-f585-b901dc8fe2f1@photo-meter.com>
Date:   Tue, 22 Feb 2022 17:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
 <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
 <20220222154314.y4scgsssl4mx5z2n@pengutronix.de>
 <00d47d39-7f93-6151-5e1a-572e75768eec@photo-meter.com>
 <20220222155135.xgzxddoz372zdsv4@pengutronix.de>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220222155135.xgzxddoz372zdsv4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wnAzhqOKORwiTDohMOQd/N7vpjrQrQVr+YiWQCkyDXWpA2DD5tq
 Llz6WbzKkS3xIXHtFxgP9Nvyy1jhRc0lFPY2NeCrLRKjHjebqcihYKAES8m5XEQSECTBTCd
 TA42hfkBJkhhehyAwtGi3hpLLeROHqIWufK3UhevvnoFpvk08XJsvs47xDmn1KYDaFiz+Kt
 1u6hkc9Iag6bDJDC8McpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fy7ustXdcFs=:C0oRxZxFr3e5CVX8fQRXzt
 SqT96mI31bjJhn9ItAzWW/BthC+vNubzdqSPH2RnsodeL8wxgMFysQ1g4zsZWnswXSpxml5Et
 N+0Fu6+3iSeYricz5UZfFbL543w1Y6iRpByakioqUDvN8wmniTjYW7DGKqyVhXYR6W2zF5TCA
 YnKJJKUl5bJv7959RQsDhgVhQABSIJmo2E1x6nd50+HAzzWt7qRWeJxQFOi3EOOTUtiVRKzIT
 oOdoWfuGHMaE2tTiE5VXATa2Gqk4D26QuEHS755m7O748L0g0H5r1Z+FpOHSdNJHRRX9KffNo
 pd96OPozquL3qczpJhAm8eWjETN6ELiXFbj0btaVo9+j1IRv2D6/KxTfJuy+v/OoGAbS8un8K
 m5CA+1/mliBf+baeUz/YY2cIUolXWgiIlcC/5iv4nDqC3jTLKn/bjs/abMbjeUfGwtXvbJqwr
 ioko/nMGggiNFp2G0VqrwMdQamLcyG2m0wtz8FHS6AhYTCHDM9jGUlcMgP/MGnOV0nLvhIX1O
 Uv/M+5MKtG5yXrYJx6FjGxbn7WqSQSBvy7vxxWsuQQWOWIqJPFcM6Y58q44M4sIvPUouaYeOh
 sPbL1yq/peDian/g8Sk2RJrkakKGLXQWkujFNCVy4bbUAmqEYtQ4JwBSoaVmkRLty6QKw3Ynf
 cDrC8Gd7UgF8xIh9pWX5GhY17oFo8IutgKU9DhBsspY/My8Zf6S9AU9EOHNMiTEHb//xwuYcC
 dCwK5/MXel+p9PzE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

>> 
>> Still any error messages?
>> 

I can relatively easy reproduce this issue. After socket opened, I need 
to write a group of 6x can_fd frames (len=64) to the socket in a cycle 
of 10ms. After 1-2 minutes TX stops and latch up appears.
Bitrates are 500000/1000000.
In latch up condition, write to socket can return  errno 11 (EAGAIN) or 
errno 105 (ENOBUFS) permanently till ifdown.

Here is my can-status

9: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode 
DEFAULT group default qlen 2000
     link/can  promiscuity 0 minmtu 0 maxmtu 0
     can <BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) 
restart-ms 0
           bitrate 500000 sample-point 0.800
           tq 50 prop-seg 0 phase-seg1 31 phase-seg2 8 sjw 8
           m_can: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
           dbitrate 1000000 dsample-point 0.700
           dtq 50 dprop-seg 0 dphase-seg1 13 dphase-seg2 6 dsjw 6
           m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp-inc 1
           clock 40000000numtxqueues 1 numrxqueues 1 gso_max_size 65536 
gso_max_segs 65535
10: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode 
DEFAULT group default qlen 2000
     link/can  promiscuity 0 minmtu 0 maxmtu 0
     can <BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) 
restart-ms 0
           bitrate 500000 sample-point 0.800
           tq 50 prop-seg 0 phase-seg1 31 phase-seg2 8 sjw 8
           m_can: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
           dbitrate 1000000 dsample-point 0.700
           dtq 50 dprop-seg 0 dphase-seg1 13 dphase-seg2 6 dsjw 6
           m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp-inc 1
           clock 40000000numtxqueues 1 numrxqueues 1 gso_max_size 65536 
gso_max_segs 65535
11: can2: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode 
DEFAULT group default qlen 2000
     link/can  promiscuity 0 minmtu 0 maxmtu 0
     can <BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) 
restart-ms 0
           bitrate 500000 sample-point 0.800
           tq 50 prop-seg 0 phase-seg1 31 phase-seg2 8 sjw 8
           m_can: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
           dbitrate 1000000 dsample-point 0.700
           dtq 50 dprop-seg 0 dphase-seg1 13 dphase-seg2 6 dsjw 6
           m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp-inc 1
           clock 40000000numtxqueues 1 numrxqueues 1 gso_max_size 65536 
gso_max_segs 65535


