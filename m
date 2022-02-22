Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A241D4BFF78
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 17:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiBVQ6d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 11:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBVQ6c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 11:58:32 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D030E16C4C4
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 08:58:05 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUooJ-1nmmcM0upd-00QmN9; Tue, 22 Feb 2022 17:58:03 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id B05033B08B7;
        Tue, 22 Feb 2022 17:55:56 +0100 (CET)
Message-ID: <06e80fbd-7d1d-d618-136c-01761807288d@photo-meter.com>
Date:   Tue, 22 Feb 2022 17:58:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
From:   Michael Anochin <anochin@photo-meter.com>
Subject: Re: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Reply-To: anochin@photo-meter.com
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
Content-Language: en-US
Organization: Czibula und Grundmann GmbH
In-Reply-To: <874k4qvq77.fsf@hardanger.blackshift.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UGKI1ikHHV7lN6dlbdZ8flES2v5kC/tKhXX/ai0mSxr6pJJKRit
 3F/MW1+RUzag1c58Mo/T66AAEDyS87EMgF4zADmp5V3F+Q9qsMohP6XMF991uOgjakkHwxt
 g8EJqJjYGELTsEx35vr0SNWjHiuE9efRobFOnkPnFG6luDfgqNfqN+jVHr6WWB+yhjHM74f
 ao3UjJ9jSUjB8M+6kKwRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4h57THU4xEg=:GTVYr5AELeShGH7P2S1dDE
 St2ZOj5lf0j+NkMViTOunc+M7Wn3RMyV3/jHhslMc/1LpZBped4QRjC54xKgBwgg8iid5pYtd
 51IrHS+FZbZ8NNH8ifCPQeJYD9uyWy8lkCbbGNHPgWHcFyufl3U2nbQ/6QF6SNnYdmkmVSXPn
 TRXaduU3oGrDXZkfpNkx5yyu4XsMilasZXB8QgAotnjweN36Mkm1AIxAS3HubHM6C6O7bX1zT
 WNcM0hPbXoW1x8tjxMwDa0AU/gLkJKGFh5JbmYjHJGOS05QW5UYegCk6TOKLLGKw2ZKrOxzQP
 xb1eX8nxg6kazj2RKUFMdw+ZNwk0W6Oxk6irJ1g+Ij6Kv1I2o+00APQXj9dkrN50b1RnUu6So
 o9Jxb70CBafDXftQ9YIeVIK1gpB/tIi2mPW9cV+nTZTaAbuq4VfErD6JuQMuD2/A/MGQ4bcdV
 IlgFQVCuPWypZy3DiXZYZFft95SJuJS5qug1R+syEMl23E22YATnvw4FyQdL6kb35YCx/Lsvd
 IOcfKgEtE0e14BHduIQ3Nn8RmaAbsb/VM5CscEdQJg8TPQyCXCqm3ISPuhdAnBqnh5MgfGdpq
 94HnLeFVDYmmG87FeCaWThiDC1qOVkmmBH86u/1Jfcb1FqBO7Mu5S6kw1zJe7gPQUOferZaEt
 xfNZ9OJlf6BRIBTFswcMSj7uAPbbJL5VSwycuMJ0d3z+w5byMN9URx24Yn9nrPDqoX8SZkeBV
 c20f4wmBwDHN+Hie
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


It fires almost always 0x5800 for tx and 0x01 for rx


ir=0x01 means RF0N set (Rx FIFO 0 New Message)
ir=0x5800 means TEFF|TEFN|TFE
(Tx Event FIFO Full, Tx Event FIFO New Entry, Tx FIFO Empty)

It seems, that m_can_isr is called to late. I catch Fifo full and empty 
flags together.

According to tcan4550 datasheet, M_CAN Revision is 3.2.1.1 ,thus >3.0


I am slightly confused by the discrepancy in Bits > 29 in m_can.c and 
mcan_users_manual_v330.pdf, section 2.3.16 Interrupt Register (IR), page 
20. But it is not my focus point.

