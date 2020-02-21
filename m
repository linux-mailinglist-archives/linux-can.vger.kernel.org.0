Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362F616803D
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2020 15:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgBUObN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 21 Feb 2020 09:31:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58094 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgBUObN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2020 09:31:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01LEV1n6075389;
        Fri, 21 Feb 2020 08:31:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582295462;
        bh=kL1E91qA5ESr8h4ljio/B8fNGQF8JnP00isnZBpmePI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rnGerTdPerqGUsioRLAl660tI2D34wm31jLpIDFKBo3bwWDOhqkgbXV9iEvuXqpY9
         MtEvyuVgpQ5/6XhyzyOJugkY/jiPOTkTeI/1vRHt+h2mNifSo+MaQJeafDKTNBuUZr
         1B+dOCwmaiW7Y+as9PTUXOubWGUuvn2jf0fykirE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01LEV1uu104367
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Feb 2020 08:31:01 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 21
 Feb 2020 08:31:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 21 Feb 2020 08:31:01 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01LEV14A001287;
        Fri, 21 Feb 2020 08:31:01 -0600
Subject: Re: [PATCH linux-master 1/3] can: tcan4x5x: Move clock init to TCAN
 driver
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>
References: <20200131183433.11041-1-dmurphy@ti.com>
 <20200131183433.11041-2-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <06af6e1d-aec4-189c-378a-77af4073a1a6@ti.com>
Date:   Fri, 21 Feb 2020 08:25:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131183433.11041-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello

On 1/31/20 12:34 PM, Dan Murphy wrote:
> Move the clock discovery and initialization from the m_can framework to
> the registrar.  This allows for registrars to have unique clock
> initialization.  The TCAN device only needs the CAN clock reference.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

I would like to have these 3 patches reviewed and integrated (post 
review) so I can work on other issues identified.

Dan


