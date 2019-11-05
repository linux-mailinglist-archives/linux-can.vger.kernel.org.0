Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EEBF06BF
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 21:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfKEUS6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 15:18:58 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:34270 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKEUS6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 15:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1572985133;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=m2sgpdizmSjdKNDY0FozsIq9lTtrjP5XKzsnNXNL3vk=;
        b=TlTiXknoHR7xxboLZvU494ZC+EsIbNdO7uPyiCiAJCI+B6Estmq5d7uO0nbbnURaKq
        7T9UKNd6BhEVsnZKOkddvtKeKCJiRUTAElrh7gtBn8DscX1hlp93CgTf/Tfn9Hts9Zy/
        ZoOlywiVESDiZVgb0+3n3BsMkeRvK+3GCyq1sjIUtSILf0UJaP5LHo9nJxzBLbmEponE
        gIL+L1ETy/6i1KR9GrlOhA1Jj9a2yl/H7Z5v92UH+zyT/IyWKYG+9+mEMXl2S6dUNY67
        VezBQjgvXUe7eqM+jzgvmInsv1JCEZET5OMyUGcpSaiS6L7dEWTYE5NTyZoy0w1StDM6
        REiw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h5l0Xq"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id C03a03vA5KIoLFY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 5 Nov 2019 21:18:50 +0100 (CET)
Subject: Re: [PATCH v3 1/3] can: mcp251x: Correctly handle restart-ms
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?Q?Timo_Schl=c3=bc=c3=9fler?= <schluessler@krause.de>,
        linux-can@vger.kernel.org
References: <1570801101-27864-1-git-send-email-schluessler@krause.de>
 <b1831201-b94e-6d0d-3194-94ced931f7b0@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4041ff15-c88f-163f-ebd6-73ddee163436@hartkopp.net>
Date:   Tue, 5 Nov 2019 21:18:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b1831201-b94e-6d0d-3194-94ced931f7b0@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 05/11/2019 19.49, Marc Kleine-Budde wrote:

Case 1:
> I think we discussed that quite some time ago. Back in the days we
> decided that if the controller does support automatic restart via the
> "128 occurrences of 11 consecutive recessive bits" and restart-ms is >
> 0, we'll let the controller do the restart.

Case 2:
> If restart-ms is 0, we'll shut down the controller and wait for a manual
> restart.

Case 3:
When a CAN controller does not support automatic restart and enters 
BUS_OFF state, we restart the CAN controller after restart-ms msecs.

Right?

Just to show the entire picture.

Regards,
Oliver
