Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50FD4BFAFC
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 15:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiBVOhn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 09:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiBVOhn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 09:37:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2E4E3AD
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 06:37:18 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMWI0-0006zC-GE
        for linux-can@vger.kernel.org; Tue, 22 Feb 2022 15:37:16 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1557-4bd7-bf13-be70.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1557:4bd7:bf13:be70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 09F053A8AB
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 14:37:16 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id qIVkGIzzFGJuIgEAs6a69A
        (envelope-from <anochin@photo-meter.com>)
        for <mkl-all@blackshift.org>; Tue, 22 Feb 2022 14:30:36 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5E4AA3A8A5
        for <mkl-all@blackshift.org>; Tue, 22 Feb 2022 14:30:36 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 598803A8A4
        for <ptx@kleine-budde.de>; Tue, 22 Feb 2022 14:30:36 +0000 (UTC)
Received: from mout.kundenserver.de ([212.227.126.187])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anochin@photo-meter.com>)
        id 1nMWBW-0006Jl-WF
        for mkl@pengutronix.de; Tue, 22 Feb 2022 15:30:35 +0100
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M59am-1nLQFy093c-001EHl for <mkl@pengutronix.de>; Tue, 22 Feb 2022 15:30:34
 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 7351F3B08B7
        for <mkl@pengutronix.de>; Tue, 22 Feb 2022 15:28:27 +0100 (CET)
Message-ID: <e3504807-06fc-b6d9-3fb1-bf8d94e2b444@photo-meter.com>
Date:   Tue, 22 Feb 2022 15:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
 <20220222132000.xiopvrtu5fmuanbz@pengutronix.de>
 <c2651e9c-d3e7-815a-6e18-8ddffc04d3d7@photo-meter.com>
 <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
From:   Michael Anochin <anochin@photo-meter.com>
Organization: Czibula und Grundmann GmbH
In-Reply-To: <20220222134419.zmycnlmhrrrewggf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ilaS9csBTGYkZ4Rev8zjX4zS6yStyO7FraS5BJVquQ/eicXtZaF
 zumElxcPwnApm2oTUg6rK2M2TD0hf3XVUJhLXXyOjmsXVzjJ0jrD2gcHRXbbWgzxov5f9uZ
 uWlLuV0c8sQZ3SVHHUqTyNQTYVVfiL/jcrBJgPwGs3UZTPXdGufgcwMYpGAeVVsIx9d344m
 UPkusQzTe0fKZhC8y+gaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n5gdoncl8BY=:yqI337Pvm6sfhme6fprTQ5
 ZPk7ZT1iTgd+NUo8Uz8ToNn2JcVJr+THA/yoCP2U5+APv65V+GHm/VwhSCgJF5JosteaKKg+k
 GE6uAkjG3A19iDy58hveZTPvBajFncBOSXNJRDit784+XHtDcNHuWAc6v/uEfG40R7rm8yrS+
 7menlPwPgVgfkABu5oxYaajnb9pTZQgyzwAsy0s5GI82k1eX/G3X/O+D55RcIw+Nc089TUYDf
 0NEER0YbHDo6htBmnT2LWgxJWcDC7I6mHa6FJPPwrypQ9UoaGRH+3dWCzo/oN7vWaPYRMvv2Z
 R30Ih9zZj6bVd0jcJ4mR18YNiEc4Tv9Lx7Qptzn0htMtBRkz8AiPJ5VzKETbsBMjWL6mzhb2j
 u3F3CJ5rfZROn5sEWYRMi5v1swymINSx72Wb0xeULb2UKpUwTLGUSUb7+VvKhfA5JlWw4LNoj
 v/+GZeHn6p9OlOAO/7PkpBYQWjX8ZQUUDZ3Jb0PuoVsihg8XHXT6RfA54cjrKWrl4+3E5n/Ve
 w01wKBfCXIVr6NxDarRuY+4lycDCMZAsGMuZM0/ak3nBXxNcU5bIvn632QnY/qXnlC+1re6ce
 NXscmsDpUaFEZVOuQ0ghU1xAPUCFKvNF0kT2cJWBnyUNj7WDijZ1xm3pBdzGhE3zwElgZODBd
 /3XksVY0g28Dg5sBLo+wZmHnwrqfVW5PhgdaZBAfjWoRlUoJhUvxbZC12lRrOFRqTSQ/dUUBF
 g2ppc66sat+eJ3Fq
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


> You can add a netdev_error() to report the error if
Done, m_can_rx_peripheral(dev) returns each time normally with 0.
I added netdev_err also after out_fail in m_can_isr, but it fires no 
error in dmesg after NOBUFS.

The curious thing is that it fails in the other place.

Sometimes I see
[ 9945.908861] tcan4x5x spi4.0 can1: can_put_echo_skb: BUG! echo_skb 11 
is occupied!

But I think, it is not my problem.



