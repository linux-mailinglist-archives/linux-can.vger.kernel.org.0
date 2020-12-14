Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B8D2D98AF
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407947AbgLNNYe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 08:24:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407828AbgLNNY1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Dec 2020 08:24:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BEDMYXJ069640;
        Mon, 14 Dec 2020 07:22:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607952154;
        bh=bXRwMth/mGo8GpueJKFO4+hjEO9i2UcOc7tAlmrGnFI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=byNK7D18upCRzoejDMqlm8ewEdmrGyLkB3dIwRdRnYdrsrFizN3Ki0pGEJGyp5BFP
         ard45s748r+6W1hWCIb6MQtYx/M32ezv9NREjlEjs4NR168BFVVeK36H389+GXl5PS
         EeNNANMB2lafksAdXlh+nXGQDvm3VUKtQedjYh9Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BEDMY8s103481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 07:22:34 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 07:22:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 07:22:34 -0600
Received: from [10.250.70.26] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BEDMXd5113305;
        Mon, 14 Dec 2020 07:22:34 -0600
Subject: Re: [RFC] m_can: cleanups
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     <kernel@pengutronix.de>, Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <79dce7d7-43a4-c46b-b1e1-33e62593ee72@ti.com>
Date:   Mon, 14 Dec 2020 07:22:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212175518.139651-1-mkl@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/12/20 11:55 AM, Marc Kleine-Budde wrote:
> Hello,
>
> this is a cleanup series for the m_can driver, mainly in preparation for
> converting the tcan4x5x to pm_runtime.
>
> regards,
> Marc

For the series including the github doc change

Reviewed-by: Dan Murphy <dmurphy@ti.com>

>
>
