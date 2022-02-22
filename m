Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD24BFB40
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiBVOzD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 09:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiBVOzD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 09:55:03 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991610C513
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 06:54:36 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MyseA-1o9FbH1X5W-00vuUz; Tue, 22 Feb 2022 15:54:33 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id C9E143B08B7;
        Tue, 22 Feb 2022 15:52:26 +0100 (CET)
Message-ID: <cde7fa96-adc6-d9ca-72a3-056569623936@photo-meter.com>
Date:   Tue, 22 Feb 2022 15:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
 <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
 <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
Cc:     linux-can@vger.kernel.org
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220222144518.j4swrtcv4rsyagem@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mOC9BRgRXr4of8z5byNr0kh/b3gP73hVZH77TIZMWGkEVjBXlmF
 wwgbf1EkycFr3ugeIueFzytyfq9Nzwd45eIBLjg7uDid8cpMcXopdMvsEI4z7SF1PHSJcU1
 IQoxVyR0FMb6ROf6X8Knbp2YQLibK6oDWEhlDi+3NWP8PQ/cZb/nFNW59zTbClkn4va8AFb
 YdKJd8IPYHuaDJRzEHvGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e5kN4xMpzW4=:tTl8BtvOHgwsD1OVeQMHPL
 nRCmS35Dac2hy7ujhiZdecw3ZYip96z6kQEdquTgpxS0d79Mf8nC+jdu/2RYXk8w6FNCYAyb0
 u2XqUejR/vgVGYJ10ngzZdxwRDKF2DF+L//L0XfTihCR74urHNf7AqnWcQYXxs3auW33azVFw
 0rxx4cw+U88/lBG7RCaj4/6q6Rr7E59GeyzyyRiMv8aAZuVisjvklGAUOVioTgTPMOLbQXJJS
 n5XeXGbWVacUucCy9QZl+oU4BOHJM4lbsbcysoPQjx68XDaKjy6WEuH1wLF5ynU/8FEKiz4Ec
 iF/mbu5SgbS6e2g2L1RUdrRNataL1dGoL3weptlcJNIP5FApovPqmhzoPQONVCc63ubk7uFoJ
 /+yrmPcdYedcBWB0sZNfUWztJS2gim5O1YboAm3nL/UVfnRr8S64bUR36lJo89sBW3xfmpUuB
 KoYLnz2Ok/4RCb2s51QqM6z4VYtovfYLZVy4LBd4TpluaSqEBT1m6D56duAxlBD5WOYG1XMnq
 +a42zuY4ClYL4XAgvTCxVROMEif7LoSRmKEjOKHrNklRRvi/5nAqNdPNtpNucjQRPHx1YsNRv
 3WPSexe5pOHXIx4Bo5bphRj/YIcgGXUvohaUIpbhE38cAHpJ04s29fMnTaCGrS9UAuVw+FKnE
 BZH159Q8XDlaHsEstJyliwiKuApIVnh7B96qUAQWYd3LUasCalfx3mlb2nacU61ugkjBxWBeO
 dRWsjjj4bVQADMUE
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
> This should not happen. Especially with the tcan driver. In a previous
> mail you stated that you are using the following mram config:
> 
> | bosch,mram-cfg =  <0x0 0 0 16 0 0 1 1>;
> 
> is this still the case? This is inconsistent with the above error
> message.
> I have tried many bosch,mram-cfg. This makes almost no difference

bosch,mram-cfg =  <0x0 0 0 16 0 0 1 1> is from Mainstream
bosch,mram-cfg =  <0x0 0 0 10 0 0 16 16> is from Mainstream
bosch,mram-cfg =  <0x0 0 0 16 0 0 8 8> is from Mainstream

I recognized, that no RXFIFO_1 is used, only RXFIFO_0.  On 
TXFIFO/TXEFIFO may be only one element is used by driver. I am not sure.
