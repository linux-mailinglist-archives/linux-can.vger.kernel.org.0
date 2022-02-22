Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26A4BFD3C
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 16:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiBVPlZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 10:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiBVPlZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 10:41:25 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5100163055
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 07:40:58 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXop2-1njl920vIy-00Y9IJ; Tue, 22 Feb 2022 16:40:56 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 74D8A3B08B7;
        Tue, 22 Feb 2022 16:38:49 +0100 (CET)
Message-ID: <1c9764e5-dd8b-853a-08e2-547acf7e9e76@photo-meter.com>
Date:   Tue, 22 Feb 2022 16:40:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Content-Language: de-DE
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
 <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
 <20220222150619.sqyagvuspbipywxl@pengutronix.de>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220222150619.sqyagvuspbipywxl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JO9o/HIoOu4fXWKWMdE/47ls0UO9DEkPPgHI8ZcP0kBP7vD0wa9
 VtAeA+U5g6AqCNWhsCYCVUh1iv/OO6tRF5SsmFZbt2ql7YiFOLNggEgL1kVLfgh31F/Nfi6
 MDb+wOSP10aYr3xL2Xvs2/qsjsF7+An10lM5d9ekXTUtQZYzgauxFcDTfjGVLpQdWzEqnW8
 f2+IyCAg9MNJdRo9qdqqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r2F8vBUcW60=:5e6fd89SNIUVd29/jaB0Ap
 ZZIUWddiOanv9wjkOykcyuB9dsSI6w1IdVZHQ4KyBA1PLSP5kaA9nt7UpXizcOUdoPQ/HucQP
 uLbdNxYJJA196RItFEa8ESEu8RMg08E33JnayIXAadGDq/f0oMAO6dcfq5an3gTmiPAoamUZ9
 BHzRm0lvmY/AfzZoE5f75Es5VBvwPgQ/h7a/wePgm1uLlCYh3igDyz4RVYAnsMzkJgaCnDhap
 CxBF235rrWI9VavrvUtxCnOHWXZkNUnY9m/xSbsNZ9fM8jzXy1/PkMhxA/GPxz/RsxNradsUA
 Hq2+P/Zh6X1h6PicYLp806PuD+hSs1ainHI6kW6TdecHWxw5iSv2pv+nZbaruEbz4FpwIkEfD
 7sjxVsJcsoBr1xahapPnYyJsMPW0Z1uxZZOuAOUqoVpw+cekyIL8cApb5GUsKeIm8ByKGvDkf
 a58otprb/k2aFSCnnLV+hCPFdChEnG7dT2yMxhUDRxP0tzuS/0ryE9042fzilS7ts81OR/BO3
 pWzTCv7DHUkrIscDVbdWEySYUiFfmKsvtmsGKcL4MhMzzsNyqKsbOmjl/wwEaVFaHdK6A5MM2
 0nvGl31cxiDR0p3l/i2ohz70A7RIs0ykeZSeg3frT3kjhbwSXA6ElgQf1X2xRT83cZZu1m4YW
 5Q2YNHXa+Y6gru42dRFne8jjU7WlBipjHEwVuAxQFOa9BagM6vWYJYxDzkqsiMaVIOxi6Bq5w
 eoPKTxND60hg/l8U
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The "BUG! echo_skb " Message was with mram-cfg=<0x0 0 0 10 0 0 16 16>.
Sorry for copypaste error.

I changed now to <0x0 0 0 16 0 0 1 1>. Thank you for information.


