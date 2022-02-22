Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816F04BFE04
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiBVQDE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 11:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiBVQCv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 11:02:51 -0500
X-Greylist: delayed 101022 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 08:02:24 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A749B106B25
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 08:02:24 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTAJl-1noPlz3E5P-00Udcl; Tue, 22 Feb 2022 17:02:20 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 9FC883B08B7;
        Tue, 22 Feb 2022 17:00:08 +0100 (CET)
Message-ID: <b946db8c-ac32-afb0-95aa-8658d1176a89@photo-meter.com>
Date:   Tue, 22 Feb 2022 17:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Content-Language: en-GB
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
X-Provags-ID: V03:K1:bWAUt1eQdg2JiQARQdfUUbGpXS9dadkRf3fesC9+35e3Qtjq173
 l5EH5CkZb4FWqHjPfjZPl0DfgSXphGaLv+XhqYpt42YVpCHwYM6gM9JM4+CdGNd88eOeHNi
 tSEv9J/xhhu/Uia8w9LUX5TkhVoYEJp2lk8/Ds8/N8alAtbnwlTxrV+ii9WbCmXwpcSjyhM
 n0mmF77yoD7R8IeRQSHjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V4h9udArruA=:iQoN2PYFiiiWKRSuyGeFOg
 RLEf+3Kk5yGcd6Tfrabnpk4iIedqXis9kT8mpRMQvnzldGCHlO4ecCuXQ7hN/vcTs4+dxM5tM
 +kWCm2fAT++zh85Y+4EhsGkbn1kE9Pi9I5D2P8kOsckZIU1c+4ZrGMjxt8JxT5pR3z+WIDu8j
 B9iL2JnGda6iiLmG9VAN12o5dSnZc1pphEFxebMjaa6rQ50QF5z4vohmDTqtQF4koztVWdyxq
 dhLmLAbuu+5+cNchY42P20Dg2wzwL3tAaiowo6Z583KURBjcSeVljuwjS9E1mZwJNQBbChORr
 DxglZIaXj4ZCyv4Ca5hmXpQcGkngBbpxOASPu+jEbNu8+Ljn8+qXeUQ29/UhNozOS4OpYr4Et
 TqTUAUlMeQuDjcJMAy46DJmxIr9me67fKrildlvfseQ1Naa/RTb60Yp7+PbIFc03tF01x+/EH
 BJlXHqezEzTVLW1MA1MwDQpvXnZs8iWrlpRGhb7bWTYnrrRRxAoKLJuGYzoLhtoJ4IlBpFILo
 eHfgDWLnOg8REbFNPt+TqOOz7DhqazaqPA+APCL7WLcJuGYjbJKHmjG5c2K0eR0W/5bqzNFw/
 P4L+HBT+0g2O1/HYid0FD+SpQhp/4w2dTBWPc4p2bI597pw6fYCYRNw4bikJpAIAVHvrRGzDc
 bo28K6cxIpsM0scJQTEkIgZjyaaEwEcLasYHHExuaqy3daVIySlApJ6rVe6ImnVtkahYpvKbk
 9pJIDKqXYwLw84ch
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Still any error messages?
No BUG-Message with  <0x0 0 0 16 0 0 1 1>. At least that is positive.

But no other Messages in in kbuf. Simply no netif_wake_queue fires. 
After that no TX possible. But RX is working.


See a log
https://pastebin.com/ZJKqTVvs
