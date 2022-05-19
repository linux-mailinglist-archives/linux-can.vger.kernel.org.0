Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B485A52D963
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 17:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiESPwo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 11:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiESPwk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 11:52:40 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D427CB09
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 08:52:39 -0700 (PDT)
Received: from photo-meter.com ([62.157.79.106]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFslN-1o5ixe12Y3-00HRJf for <linux-can@vger.kernel.org>; Thu, 19 May 2022
 17:52:37 +0200
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 29EEE3B08B7
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 17:51:16 +0200 (CEST)
Message-ID: <9e431f19-897e-7bff-68bb-7ac7bb9fd757@photo-meter.com>
Date:   Thu, 19 May 2022 17:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: anochin@photo-meter.com
Content-Language: en-US
To:     linux-can@vger.kernel.org
From:   Michael Anochin <anochin@photo-meter.com>
Subject: can, m_can, tcan4x5x : big jitter between the packets by sending
Organization: Czibula und Grundmann GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HGE2BWAZpX2MpwXf/zZk1mdHLMR3h74+lhNamsw2QazNPiWUR57
 1dc9uRkMRFptoCler5saSY2MephtcmSZv6q3UkN8eaJ779zWYkzLo9guQjr04mSesSEz4zy
 RMw0Jf8n+Z7BJRn1IOf8Of5Yfd0Jll9NTBNiD+ihfDTM/KXOj4+9/Wk/cZ3en2Pn+rTPatl
 Jzhfda2BiDYTvC2cDXINw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tWRoVzU7b2o=:WCs9XWx9oH6o2Bbkm3qpX/
 97Jc66F6e3Nsse4hCpM1yp3hazb2LsTk6Tz1qlqWYv7Q5vDoNNOY7sxVwc5rgGghhLyfZ6Ii2
 MLo0nxS5bizvDNcMshbrqUUDlfnAbxSNpZLIHQ5j+SEIOBpp6uRUZS4EfVdpHyXgQy88twZQK
 2AaUiokrXF+Qrbto10MXrYCfmXbWN5tbVFjpDfdexYo5Yk/AGGBqFwTQiQ+IVCCqlWPa6Sh4B
 Vio3UqjCFJfYFkqT7oMvVzb1ysgDDtECMqVzZg9+TttNmmfkO2uzNRmIq9tRNhqB4v4rHJ46t
 UbioxL157jpGHR4Zfq2iJjvly14Ktxjzv07AFwsHcb8nKdOxjZu6+5PtHZMhyUXgmOTsZGT7n
 7oG0MT/WbF7yhJk4AnuY423Sbg1bZ9jLEOzzdlxdEu8izUIKxj2J3aCT+wdSPn1s7DzqaH0o8
 QsPK51C0ZDU453PsdsaVxbzHZjQ2fRsbXqHDPSZR56Ey0QQTFmqPF93zFqq2mJUA5U4OQam1d
 bRKdCfUacL674HZ5QPc79KSAwZEVfDMk+RsSaXG9iDSqAJC0n8ryVyHUhwbrRudYgcl4kY+Sr
 djw5I3ypMNzGCCSsqmA1r3V+DuW3EgE3LeQesJrTGNbg/M6+oNM7kx5LqIbauXpmE7NdgJzU+
 tpBeOT9R4AxT4NOLc74+4dfJyixvYYGLeVpPq978BLu7U1UC0mnTq4qFjzS/jtBv0i7YCrtev
 hUElIg5LlcPELfPlNwJTwOgYwhJUfnPzA1wUPVNM3hDl+1VLa4m8uXdvDJQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

my application continuously sends 64 bytes CANFD packets with 1MBit/s at 
the 10ms interval. I use tcan4450 on the RPI4 with 5.10.103 Kernel and 
raspbian. No other significant processes load the CPU.

When I monitor the traffic with a PCAN adapter on a Windows PC, I notice 
that the packets sometimes arrive with a delay of 5-9ms. But the next 
following packet arrive faster as 10ms. My desired interval of 10ms is 
kept at the jitter of +/- 9ms.

Running the App on only one CPU core using tasksel improve the jitter 
somewhat.

Am I the only one who observes such large jitter or is the m_can 
implementation at Perepherie (spi) not so fast from the throughput and 
is completely normal.

Maybe I should switch to 5.17 kernel? On 5.17 there are bulk read/write 
function for spi regmap.


Thanks and Best Regards,
Michael Anochin
