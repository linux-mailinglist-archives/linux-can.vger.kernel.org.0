Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4C27549F
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIWJi4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 05:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIWJi4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 05:38:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CDFC0613CE
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 02:38:55 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B11D823E3F;
        Wed, 23 Sep 2020 11:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600853933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7CUKY6gfmuCwt8DjnRLcCQCSrVrA1/IE9FBVfxi0WI=;
        b=Pwxt+6kJHmoYIhr7URlhUQ/foFUPE51nt7IYwvS2t4KxSs2EjSXMaQAIwiRBkuvYq6Nin/
        a0QzyEUzLClRWLXxOVjtWE/HtGZb/FAFGHADTLcZpIcL6qmbT5ypPF0OM7+NQkI3evz0jA
        uB2Uc3I67yHhj6wmk6pUzzi6Z6FifOA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Sep 2020 11:38:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de,
        linux-can@vger.kernel.org
Subject: Re: [PATCH 20/20] can: flexcan: add lx2160ar1 support
In-Reply-To: <956dcdd5-b334-f5e5-dde1-bea07929f666@pengutronix.de>
References: <20200922144429.2613631-1-mkl@pengutronix.de>
 <20200922144429.2613631-21-mkl@pengutronix.de>
 <4ffe89fbb4c91a9587622862c3509180@walle.cc>
 <5b3c07ab-ca8c-d43d-f4e0-7155d358648d@pengutronix.de>
 <0e90e8234d38830749ad8de380837eb2@walle.cc>
 <8e2e2994-a3c8-cf06-012a-fcb0ac18a888@pengutronix.de>
 <DB8PR04MB67955FEC9B6A44A1A2C04DE8E6380@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <956dcdd5-b334-f5e5-dde1-bea07929f666@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <2aa4e8536b7fd61a03e9b746ee37eb91@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2020-09-23 10:58, schrieb Marc Kleine-Budde:
> On 9/23/20 10:31 AM, Joakim Zhang wrote:
>> I check locally, for LS1028A, it also uses the "fsl,lx2160ar1-flexcan"
>> compatible string, so I think LS1028A should reuse IP core from 
>> LX2160A.
> 
> This means at least the IP core is compatible :) I think we don't know 
> for sure,
> if it's the same version of the IP core.

Ok I've just tested this series on the LS1028A and can confirm it 
(still) works.

FWIW, because the pull request is already out:
Tested-by: Michael Walle <michael@walle.cc> [on LS1028A SoC]

-michael
