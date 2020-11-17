Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C862B5E76
	for <lists+linux-can@lfdr.de>; Tue, 17 Nov 2020 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgKQLgg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 17 Nov 2020 06:36:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:13664 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgKQLgg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 17 Nov 2020 06:36:36 -0500
IronPort-SDR: YVawogSooEHZjG3gVDUOuUpBI/Q7EV/W2vuI4hoa+L6XaT1uRFMlWMNOjSTPbzdEqupYclvYZf
 U1d1jvAXcL9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="235055376"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="235055376"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 03:36:35 -0800
IronPort-SDR: 5H8ibe/Eas8Hn9yBRDalvTQdNMH7/KA/GKfPbH0uDr/nrHOCiKGv6TAWwxED/IIwcdNOw/4zRV
 QA38yupT70jw==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="325128604"
Received: from amwebb-mobl2.ger.corp.intel.com (HELO pflykt-mobl1.ger.corp.intel.com) ([10.252.19.117])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 03:36:33 -0800
Received: by pflykt-mobl1.ger.corp.intel.com (Postfix, from userid 1100)
        id 9D56A3200D5; Tue, 17 Nov 2020 13:36:30 +0200 (EET)
Message-ID: <3b81ac4f9f845627a1f2f9170c1a76b60366797b.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/1] NET: mcan: Move runtime PM enable/disable to
 m_can_platform
From:   Patrik Flykt <patrik.flykt@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, dmurphy@ti.com,
        sriram.dash@samsung.com, jarkko.nikula@intel.com
Date:   Tue, 17 Nov 2020 13:36:30 +0200
In-Reply-To: <20201023115800.46538-2-patrik.flykt@linux.intel.com>
References: <20201023115800.46538-1-patrik.flykt@linux.intel.com>
         <20201023115800.46538-2-patrik.flykt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 2020-10-23 at 14:58 +0300, Patrik Flykt wrote:
> This is a preparatory patch for upcoming PCI based M_CAN devices.
> The current PM implementation would cause PCI based drivers to
> enable PM twice, once when the PCI device is added and a second
> time in m_can_class_register(). This will cause 'Unbalanced
> pm_runtime_enable!' to be logged, and is a situation that should
> be avoided.
> 
> Therefore, in anticipation of PCI devices, move PM enabling out
> from M_CAN class registration to its only user, the
> m_can_platform driver.
> 
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
> v2: Rebased on mkl/linux-can.git 9146843b11b6

Ping ping?

	Patrik


